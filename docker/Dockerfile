FROM ubuntu:19.04

LABEL description="A docker image for Garnet test flow"
LABEL maintainer="keyi@cs.stanford.edu"

RUN apt-get update && \
    apt-get install -y --no-install-recommends git gcc-8 g++-8 python3 \
            python3-pip verilator cmake curl wget \
            libigraph0-dev zlib1g-dev libpng-dev libjpeg-dev python3-dev \
            python3-setuptools make python3-wheel libncurses5-dev \
            csh imagemagick libgmp-dev libmpfr-dev libmpc-dev && \
        apt-get clean

RUN ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip && \
    ln -s /usr/bin/gcc-8 /usr/bin/gcc && \
    ln -s /usr/bin/g++-8 /usr/bin/g++
