---
title: "Terminal Tips"
date: "2014-07-13"
author: "Spencer Lyon"
series: ["Hacking"]
---


# Terminal

## Connecting via flooty

This command starts a process so someone can log in to my machine:

```bash
flootty --create TomTerminal --url=https://floobits.com/cc7768/ChaseTomShared --unsafe
```

This command allows someone to log in after the command above has been entered

```bash
flootty --url=https://floobits.com/cc7768/ChaseTomShared TomTerminal
```

## git

I like to view diffs in Kaleidoscope.

There are a few ways

```bash
# This compares file/folder XXX from branch1 and branch2.
git difftool branch1 branch2 XXX
```

```bash
# This compares file/folder XXX from current working state and branch2
git difftool HEAD branch2 XXX
```

## Setting up ssh into stern machine.

I had to run the following commands on the stern desktop

```
sudo apt-get install openssh-server
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults
sudo chmod a-w /etc/ssh/sshd_config.factory-defaults
sudo restart ssh

sudo touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

Then I had to copy contents of the file `~/.ssh/id_rsa.pub`  on this machine to `~/.ssh/authorized_keys` on the office machine. I did this with the following command:

```
cat ~/.ssh/id_rsa.pub | ssh username@ip_address -p PORTnumber 'cat >> .ssh/authorized_keys'
```

Then I was good to go.

## Slow ssh to/from osx

I needed to change the following two things.

On client machine in `/ect/ssh_config` I replaced

```
# GSSAPIKeyExchange yes
```

with

```
GSSAPIKeyExchange no
```


On the remote machine in `/ect/sshd_config` I replaced

```
#UseDNS yes
```

with

```
UseDNS no
```

## Restart computer via terminal

```
ssh user@host sudo /sbin/shutdown -r now
```
