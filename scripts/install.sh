#!/bin/bash -e

SOURCE="${BASH_SOURCE[0]}"
REQUIREMENTS=`(dirname ${SOURCE})`/requirements.txt

# build coreir here
git clone --depth 1 https://github.com/leonardt/pycoreir.git
git clone --depth 1 https://github.com/rdaly525/coreir pycoreir/coreir-cpp

pip install -e pycoreir/

# install this last since we already have a coreir built
pip install -r ${REQUIREMENTS}

# re-compile again with the patch
# there is a bug in ABI with regex
# see https://github.com/rdaly525/coreir/issues/737
cd pycoreir/coreir-cpp && \
    git apply /GarnetFlow/patches/coreir_path_cxxopt && \
    cd build && \
    make -j2 && \
    cd /GarnetFlow

# clone other repos
git clone --branch simple_mapper --depth 1 https://github.com/StanfordAHA/garnet
git clone --depth 1 https://github.com/StanfordAHA/Halide-to-Hardware

# install Genesis and apply patch
git clone --depth 1 https://github.com/StanfordVLSI/Genesis2
rm -rf Genesis2/Genesis2Tools/PerlLibs/ExtrasForOldPerlDistributions/Compress

# download the prebuilt Halide library
cd Halide-to-Hardware
curl -s https://api.github.com/repos/StanfordAHA/Halide-to-Hardware/releases/latest?access_token=$GITHUB_TOKEN | grep browser_download_url | cut -d '"' -f 4 | wget -qi -
tar zxvf halide_distrib.tgz
ls distrib
cd ../

date
