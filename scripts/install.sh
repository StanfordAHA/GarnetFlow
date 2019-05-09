#!/bin/bash -e

SOURCE="${BASH_SOURCE[0]}"
REQUIREMENTS=`(dirname ${SOURCE})`/requirements.txt

# build coreir here
git clone --depth 1 https://github.com/rdaly525/coreir coreir
# there is a bug in ABI with regex
# see https://github.com/rdaly525/coreir/issues/737
cd coreir && \
    git apply /GarnetFlow/patches/coreir_path_cxxopt && \
    cd /GarnetFlow
cd coreir/build && cmake .. && make -j2 && cd /GarnetFlow

# install this last since we already have a coreir built
pip install -r ${REQUIREMENTS}


# clone other repos
git clone --branch simple_mapper --depth 1 https://github.com/StanfordAHA/garnet
git clone --depth 1 https://github.com/StanfordAHA/Halide-to-Hardware

# install Genesis and apply patch
git clone --depth 1 https://github.com/StanfordVLSI/Genesis2
rm -rf Genesis2/Genesis2Tools/PerlLibs/ExtrasForOldPerlDistributions/Compress

# download the prebuilt Halide library
cd Halide-to-Hardware
# I give up. someone else can try it.
# export RELEASE_ADDR=https://api.github.com/repos/StanfordAHA/Halide-to-Hardware/releases/latest
# curl -X GET -u $GITHUB_TOKEN:x-oauth-basic ${RELEASE_ADDR} | grep browser_download_url | cut -d '"' -f 5 | wget -qi -
wget https://github.com/StanfordAHA/Halide-to-Hardware/releases/download/v0.0.3/halide_distrib.tgz
tar zxvf halide_distrib.tgz
ls distrib
cd ../

date
