#!/bin/bash -e

SOURCE="${BASH_SOURCE[0]}"
REQUIREMENTS=`(dirname ${SOURCE})`/requirements.txt

# build coreir here
git clone --depth 1 --branch rm-ubuf https://github.com/rdaly525/coreir coreir
# there is a bug in ABI with regex
# see https://github.com/rdaly525/coreir/issues/737
cd coreir && \
    git apply /GarnetFlow/patches/coreir_path_cxxopt && \
    cd ..
cd coreir/build && cmake .. && make -j2 && cd ../../

# pin pycoreir version since the latest one doesn't work
pip install --ignore-installed coreir==2.0.19

# install this last since we already have a coreir built
python python_repo.py

# install genesis2
pip install genesis2

# clone garnet
git clone --depth 1 https://github.com/StanfordAHA/garnet

# create the lake repo
export COREIR_DIR=/GarnetFlow/scripts/coreir # lake needs to know where coreir is
git clone --branch master --depth 1 https://github.com/joyliu37/BufferMapping
cd BufferMapping/cfunc
make lib
cd ../../

# create Halide
git clone --depth 1 https://github.com/StanfordAHA/Halide-to-Hardware

# download the prebuilt Halide library
cd Halide-to-Hardware
# I give up. someone else can try it.
# export RELEASE_ADDR=https://api.github.com/repos/StanfordAHA/Halide-to-Hardware/releases/latest
# curl -X GET -u $GITHUB_TOKEN:x-oauth-basic ${RELEASE_ADDR} | grep browser_download_url | cut -d '"' -f 5 | wget -qi -
wget -q https://github.com/StanfordAHA/Halide-to-Hardware/releases/download/v0.0.8/halide_distrib.tgz
tar zxf halide_distrib.tgz
ls distrib
cd ../

date
