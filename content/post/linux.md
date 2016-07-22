---
title: "Linux Tips"
date: "2013-12-28"
author: "Spencer Lyon"
series: ["Hacking"]
tags: ["tips"]
---


## dpkg errors

I wasn't able to get `apt-get` to do anything. The problem was that my `/boot` partition was full.

I checked that this was the problem using

```bash
df -i
```

and

```bash
df -i
```

I then iterated on the following two commands:

```bash
dpkg -l linux-{image,headers}-"[0-9]*" | awk '/^ii/{ print $2}' | grep -v -e `uname -r | cut -f1,2 -d"-"` | grep -e '[0-9]' | xargs sudo apt-get -y -f purge
```

and

```bash
sudo apt-get -f autoremove
```

Somehow it worked.

Followed hints [here](http://askubuntu.com/questions/89710/how-do-i-free-up-more-space-in-boot)


### curl certs

Sometimes when updating a Julia package that uses `curl` to get dependencies I get the following error:

```
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                Dload  Upload   Total   Spent    Left  Speed
 0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (77) error setting certificate verify locations:
 CAfile: /etc/pki/tls/certs/ca-bundle.crt
 CApath: none
================================[ ERROR: Blosc ]================================

failed process: Process(`curl -f -o c-blosc-1.5.3.tar.gz -L https://github.com/Blosc/c-blosc/archive/v1.5.3.tar.gz`, ProcessExited(77)) [77]
while loading /home/ap/.julia/v0.3/Blosc/deps/build.jl, in expression starting on line 17

================================================================================
INFO: Building HDF5
INFO: Building LightXML
INFO: Building ZMQ

================================[ BUILD ERRORS ]================================

WARNING: Blosc had build errors.

- packages with build errors remain installed in /home/ap/.julia/v0.3
- build the package(s) and all dependencies with `Pkg.build("Blosc")`
- build a single package by running its `deps/build.jl` script

===============================================================================
```

To fix it I entered the following from the terminal

```sh
echo "cacert=/etc/ssl/certs/ca-certificates.crt" >> ~/.curlrc
```

That fixed it
