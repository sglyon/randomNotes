---
title: "Using Gcloud"
date: "2018-04-07"
author: "Spencer Lyon"
series: ["Hacking"]
tags: ["tips", "cloud"]
---


## Making a container-based instance


How to list possible images

```shell
gcloud compute images list \
    --project cos-cloud \
    --no-standard-images
```

Pick a name from that list. One of mine was `cos-stable-65-10323-69-0`. We will refer to this as `IMAGE_NAME` below.


We create an instance using (NOTE: You can change the zone and machine type also)

```shell
gcloud compute instances create INSTANCE_NAME --image IMAGE_NAME --image-project cos-cloud --zone us-east1-d --machine-type n1-highcpu-8
```

We can connect to it using

```shell
gcloud compute ssh INSTANCE_NAME
```


## Using Docker

Once you've ssh'd in you can `docker pull` any public image

Then you can `docker run`

Then to get stuff out of the container you can  `docker cp`

## Using gcloud inside instance

When I'm ssh'd into the instance I can access `gcloud` and `gsutil` from within an image.

First, pick an image tag from [here](https://hub.docker.com/r/google/cloud-sdk/). Below I use `196.0.0-slim`

Then pull it and authenticate (remember, run this from inside the instance)

```shell
docker pull google/cloud-sdk:196.0.0-slim
docker run -it --name gcloud-config google/cloud-sdk:196.0.0-slim gcloud auth login
```

Now you can use the volume named `gcloud-config`, which has your auth creds stored

```shell
docker run --rm -ti --volumes-from gcloud-config google/cloud-sdk:196.0.0-slim
```

Now that we are in this image we can use `gcloud` and `gsutil` commands.

### Example: make bucket, upload file

After running

```shell
docker run --rm -ti --volumes-from gcloud-config google/cloud-sdk:196.0.0-slim
```

we can make a bucket

```
gsutil mb gs://BUCKET_NAME
```

If we had mounted a volume from our instance filesystem  (perhaps including files we `docker cp` out of an image) by doing something like

```shell
docker run --rm -ti --volumes-from gcloud-config -v /home/sglyon/save:/save  google/cloud-sdk:196.0.0-slim
```

we could then push the object to the bucket

```shell
gsutil cp /save/file gs://BUCKET_NAME
```

