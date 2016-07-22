---
title: "Cloud tips"
date: "2014-10-05"
author: "Spencer Lyon"
series: ["Hacking"]
tags: ["Cloud", "Computing", "AWS", "GCE"]
---


# Cloud

## AWS

### Persistent notebook

I have a persistent instance running.

I followed [this blog post](https://grollchristian.wordpress.com/2014/09/01/ijulia-for-amazon-ec2/) to get it set up.

I can connect to it via

```bash
ssh -i ~/dotfiles/sglyon-mbp.pem.txt ubuntu@ec2-54-201-41-126.us-west-2.compute.amazonaws.com
```

`ipython notebook --profile=julia` is running. I can connect to it from any browser by going to

```
https://ec2-54-201-41-126.us-west-2.compute.amazonaws.com:8998
```

The password is `lyon0409`.

I needed to add the `IJulia all tcp` security group to the instance through the AWS online management console.

#### new user

I made a new user here by following the ideas [here](http://brianflove.com/2013/06/18/add-new-sudo-user-to-ec2-ubuntu/)

#### Mounting a volume

I mounted a volume to `~/storage` (`sudo mount /dev/xvdf /home/sglyon/storage)`, but didn't have permission to do anything. To fix that I chowned it: `sudo chown -R sglyon ~/storage`

## GCE

First step is to install the tools. This is a one time thing where I enter this command:

```
curl https://sdk.cloud.google.com | bash
```

Then follow the prompts and such until it is installed. I chose the directory `~/google-cloud-sdk`

I didn't have it alter my path for me, but  I added the following line in my list where I set `$PATH` from within my ~/.zshenv:

```
$HOME/google-cloud-sdk/bin
```

### Julia and GCE

I (partially) followed [this blog post](http://www.blog.juliaferraioli.com/2013/12/julia-on-google-compute-engine.html) to get things started.

To create a new instance from the command line I need to run the following

```
gcloud compute --project "sgl-julia" instances create "instance-name" --zone "us-central1-b" --machine-type "n1-standard-1" --network "default" --maintenance-policy "MIGRATE" --scopes "https://www.googleapis.com/auth/devstorage.read_only" --image "https://www.googleapis.com/compute/v1/projects/sgl-julia/global/images/julia-src-deb-10212014" --no-boot-disk-auto-delete
```

where `instance-name` is replaced with the actual name of the instance I want to create.

I can then ssh into the new instance (after it is created) by running

```
gcloud compute --project "sgl-julia" ssh --zone "us-central1-b" "instance-name"
```

If I want to select a different type of instance, I would change the `--machine-type` parameter name. See [this page](https://developers.google.com/compute/pricing) for an explanation of the different types and prices.

To turn off (delete) my instance I would enter the following command:

```
gcloud compute --project "sgl-julia" instances delete "instance-1" --zone "us-central1-b"
```

If I also wanted to delete the corresponding persistent disk I would enter

```
gcloud compute --project "sgl-julia" disks delete "instance-1" --zone "us-central1-b"
```

#### Writing the package

I had to install [this script](https://github.com/markcarver/mac-ssh-askpass) in order for ssh to work. I did the following:

```
cd ~/Downloads
git clone https://github.com/markcarver/mac-ssh-askpass
cd mac-ssh-askpass
sudo ./INSTALL
```

The package also requires that `gcloud` and friends are installed.
