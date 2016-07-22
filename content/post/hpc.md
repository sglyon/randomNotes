---
title: "HPC"
date: "2015-05-11"
author: "Spencer Lyon"
series: ["Hacking"]
tags: ["tips", "HPC", "computing"]
---

# Julia and mercer

Here are some tips, tricks I've picked up for working with Julia on NYUs super
computer.

## Installing Julia

I have a shell script that I periodically run to download the latest released
version of Julia:

```sh
#!/usr/bin/env sh

wget -O julia_binary.tar.gz https://julialang.s3.amazonaws.com/bin/linux/x64/0.4/julia-0.4-latest-linux-x86_64.tar.gz

rm -rf $WORK/src/julia*
mkdir -p $WORK/src/julia
tar -C $WORK/src/julia -zxf julia_binary.tar.gz --strip-components=1
rm julia_binary.tar.gz

# prepend julia to path
export PATH=$WORK/src/julia/bin:$PATH

# remove old symlink and make a new one
mkdir $WORK/bin
rm -f $WORK/bin/julia
ln -s $WORK/src/julia/bin/julia $WORK/bin/julia
```

I put this in a file `$WORK/bin/update_julia`, then whenever I need to update
my julia installation I do `bash $WORK/bin/update_julia`.

This script will put the Julia binary in `$WORK/bin/julia` (that's what I enter
to run Julia.)

## Installing specific packages

Most packages are installable using either `Pkg.clone` or `Pkg.add`. However,
some require extra setup.

Here are specailized instructions for installing specific packages.

### HDF5.jl

I first tried `Pkg.add("HDF5")`. That didn't work. The problem is that I don't
have access to a package manager on mercer, so I need to link against libhdf5
that is already on mercer.

I tracked down the shared library on mercer and found that it was at the
following location (NOTE: you might want to check it there are more recent
versions available):

`/share/apps/hdf5/1.8.14/openmpi/intel/lib/libhdf5.so.9`.

Then I edited `$HOME/.julia/v0.4/HDF5/deps/deps.jl` to look like this:

```julia
# This is an auto-generated file; do not edit

# Pre-hooks

# Macro to load a library
macro checked_lib(libname, path)
    ((VERSION >= v"0.4.0-dev+3844" ? Base.Libdl.dlopen_e : Base.dlopen_e)(path) == C_NULL) && error("Unable to load \n\n$libname ($path)\n\nPlease re-run Pkg.build(package), and restart Julia.")
    quote const $(esc(libname)) = $path end
end

# Load dependencies
@checked_lib libhdf5 "/share/apps/hdf5/1.8.14/openmpi/intel/lib/libhdf5.so.9"
# Load-hooks
```

You might need to create both the `HDF5/deps` folder and the file `deps.jl`.
You should now be able to start a Julia session and run `using HDF5` and it
will work without a problem.

You do __not__ need to run `Pkg.build("HDF5")` after updating deps.jl

### MbedTLS.jl

If you need to install MbedTLS.jl or if it is a dependency of something else
you need to install, you will probably see an error about `cmake` not being
available when you do `Pkg.add("MbedTLS")`.

The fix here is to simply run `module load cmake` at the shell prompt, then
start Julia in that same session, and try `Pkg.add("MbedTLS")` or
`Pkg.build("MbedTLS")` again (run `Pkg.build` if you already tried `Pkg.add`
and it failed).

# MPI jobs

I got this script from [here](http://csc.cnsi.ucsb.edu/docs/running-jobs-torque)

NOTE: if you are using Julia with multiple processors, skip this section and
move to the next one.

```bash
#!/bin/sh
##############################################################################
# IMPORTANT:  the next line determines how many nodes to run on
#  nodes is number of nodes, ppn= processors (cores) per node
#PBS -l nodes=2:ppn=4
#
# Make sure that we are in the same subdirectory as where the qsub command
# is issued.
#
cd $PBS_O_WORKDIR
#
#  make a list of allocated nodes(cores)
#  Note that if multiple jobs run in same directory, use different names
#     for example, add on jobid nmber.
cat $PBS_NODEFILE > nodes
# How many cores total do we have?
NO_OF_CORES=`cat $PBS_NODEFILE | egrep -v '^#'\|'^$' | wc -l | awk '{print $1}'`
NODE_LIST=`cat $PBS_NODEFILE `
#
# Just for kicks, see which nodes we got.
echo $NODE_LIST
#
# Run the executable. *DO NOT PUT* a '&' at the end!!
#
mpirun -np $NO_OF_CORES -machinefile nodes ./pi3 >& log
#
#########################################
```

The following also looked like good resources:

- https://wikis.nyu.edu/display/NYUHPC/Running+jobs+-+MPI
- https://wiki.anl.gov/cnm/HPC/Submitting_and_Managing_Jobs/Example_Job_Script

## Julia on a cluster

I can't just do `julia -p N` or `addprocs(N)` to get it to work. That would
give me `N` procs on the login node. What I need instead is to use the
`machinefile` option for starting Julia and give it  the `$PBS_NODEFILE`. This
is an example of a PBS script I had that worked:

```bash
#PBS -l nodes=1:ppn=20
#PBS -l walltime=10:00:00
#PBS -N gerzensee
#PBS -M spencer.lyon@nyu.edu
#PBS -m abe
#PBS -j oe
#PBS -t 1,9

module purge

# this moves us to the directory where qsub was submitted
# should be $WORK/Research/Gerzesee/Code/international
cd $PBS_O_WORKDIR

# cat $PBS_NODEFILE | sed -e 's/.local$/-ib.ibnet/' > my_machines
# cat $PBS_NODEFILE > my_machines

# run the code! -- use machinefile to start one julia on each process
/work/sgl290/bin/julia --machinefile $PBS_NODEFILE driver.jl
```

In this example I started two jobs (with `PBS_ARRAYID` equal to 1 and 9). Each
job used 20 cores on one node for 10 hours. The path `/work/sgl290/bin/julia`
is the path that was set up for me by running the shell script from above.

In this example `driver.jl` looked like this:

```julia
include("main.jl")
using JLD

for i in workers()
    remotecall_fetch(i, include, "main.jl")
end

# set up arguments
model_id = parse(Int, get(ENV["PBS_ARRAYID"], "1"))

# CODE TO DO THE WORK USING using all the cores.
```

There are a few things to point out about this code. First `main.jl` is a file
that collects all the code I will be running. I first call `include("main.jl")`
and then go through all the workers and call `remotecall_fetch(i, include,
"main.jl")` to load it on each process. I do it this way for a few reasons:

- Loading is only on the master process first allows all precompilation to take
place without multiple processes trying to write the same `.ji` files at the
same time
- I include the file sequentially on all workers again so that no worker steps
on another worker's toes.

I then extract an integer `model_id` that specifies which job is currently
running. This number corresponds to the job number from the pbs script
(integers 1 and 9 in the example above). I use this to drive which
parameterization I am working with.

The comment at the end is simply there as a placeholder for you to put the code
that actually does the work.

# Sharing folders

To share a folder `/scratch/sgl290/awesomeness` with user `abc123` I would need
to enter the following commands on mercer:


```bash
setfacl -m u:abc123:rx /scratch/sgl290
setfacl -Rm u:abc123:rwx,d:u:abc123:rwx /scratch/sgl290/awesomeness
```

The first command gives read and execute permissions to my scratch folder --
necessary for letting them enter the folder and it's children.

The second command gives him read, write, exceute permissions to the
awesomeness folder all sub files/folders.
