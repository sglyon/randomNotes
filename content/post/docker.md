---
title: "Using Docker"
date: "2015-07-01"
author: "Spencer Lyon"
series: ["Hacking"]
tags: ["tips"]
---

Common commands I use:

- `boot2docker up`: This launches the boot2docker daemon on osx. After running I then have to copy/paste the `export` statements printed by this command to set up ports. An alternative is `$(boot2docker shellinit)`, which will do the copy/pase of `export`s for me.
- `docker ps -a`: lists all containers
- `docker rm $(docker ps -a -q)`: remove all containers (running or not)
- `docker images`: list local images
- `docker run IMAGE_NAME`: runs the docker image. NOTE: often not useful because you also need to
- `docker run -it IMAGE_NAME COMMAND`: runs `COMMAND` inside the image `IMAGE_NAME` and leaves you in terminal/interactive mode. This is most often what I use. Often the command is `/bin/bash` to just drop me into the terminal
- `docker run -it -v LOCAL_PATH:REMOTE_PATH IMAGE_NAME COMMAND`: runs `COMMAND`: like the above, but maps a local file/folder at `LOCAL_PATH` to the image's filesystem at `REMOTE_PATH`
- `docker stop $(docker ps -a -q)`: stops all processes
- `docker build -t USERNAME/IMAGE_NAME .`: Use the dockerfile in the current directory to build an image. Tag the image with the `USERNAME` and `IMAGE_NAME`
- `docker search NAME`: searches dockerhub for images containing `NAME`
- `docker pull USERNAME/IMAGE_NAME`: Pulls image `USERNAME/IMAGE_NAME` from dockerhub
- `docker history USERNAME/IMAGE_NAME`: shows the history of an image
- `docker rmi IMAGE_ID1 IMAGE_ID2`: remove images by ID. Can list multiple images at once
- `docker stop IMAGE_ID`: stops an image
- `docker run -p IMAGE_PORT:LOCAL_PORT ....`: runs an image (with other args and image name omitted) and maps port `IMAGE_PORT` on the image to `LOCAL_PORT` on my machine.
