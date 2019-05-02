FROM ubuntu:19.04

LABEL description="A docker image for Garnet test flow"
LABEL maintainer="keyi@cs.stanford.edu"

RUN apt-get update && \
    apt-get -y install gcc-8 g++-8 python3 python3-pip verilator cmake llvm-8 clang-8 && \
    apt-get clean

RUN rm /usr/bin/python && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip
