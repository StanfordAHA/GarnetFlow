# GarnetFlow
[![Build Status](https://travis-ci.com/StanfordAHA/GarnetFlow.svg?branch=master)](https://travis-ci.com/StanfordAHA/GarnetFlow)

Reliable end-to-end test flow for Garnet

# How to run locally
You need to have docker installed on your local machine. Please follow
[this guid](https://docs.docker.com/install/) to install Docker CE version.

After installing docker, please follow the commands below
```Bash
# pull docker image from docker hub
docker pull keyiz/garnet-flow

# give the image a name "garnet" and run it in the background
docker run -d -it --name garnet keyiz/garnet-flow bash

# copy scripts and patches to the image top-level directory
docker cp scripts/ garnet:/GarnetFlow
docker cp patches/ garnet:/GarnetFlow/patches

# build all dependences (this takes awhile!)
docker exec -i garnet bash -c "cd GarnetFlow && ./install.sh"

# run the tests
docker exec -i garnet bash -c "cd GarnetFlow && ./run.sh"
```

To attach to the running container, simply do
```Bash
docker attach garnet
```

You can stop and container and then remove it by invoking
```Bash
docker stop garnet
docker rm garnet
```

# How to run on kiwi
kiwi already has the latest docker image. You can skip the `docker pull` part. However,
by default, your user account won't be in `docker` user group. Please contact me (Keyi)
or Stephen Richardson to add you to the docker group. You may also need to use a
different container name other than `garnet` since very likely someone else is using
it.