FROM ubuntu:19.04

LABEL description="A docker image for Garnet test flow"
LABEL maintainer="keyi@cs.stanford.edu"

RUN apt-get update && \
    apt-get -y install git gcc-8 g++-8 python3 python3-pip verilator cmake \
        llvm-8 clang-8 curl wget libigraph0-dev zlib1g-dev libpng-dev libjpeg-dev && \
    apt-get clean

RUN rm /usr/bin/python && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip
