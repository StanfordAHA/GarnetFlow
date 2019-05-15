FROM keyiz/garnet-flow

LABEL description="A docker image for Garnet test flow with cad"
LABEL maintainer="keyi@cs.stanford.edu"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
        apt-get install -y --no-install-recommends tcl && \
        ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
        dpkg-reconfigure --frontend noninteractive tzdata && \
        apt-get clean
