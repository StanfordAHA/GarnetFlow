#!/bin/bash -xe

SOURCE="${BASH_SOURCE[0]}"
REQUIREMENTS=`(dirname ${SOURCE})`/requirements.txt

# build coreir here
git clone https://github.com/leonardt/pycoreir.git
# apply coreir custom patch
git clone https://github.com/rdaly525/coreir pycoreir/coreir-cpp
cd pycoreir/coreir-cpp && git apply /GarnetFlow/patches/coreir_path_cxxopt && cd /GarnetFlow
pip install -e pycoreir/

# install this last since we already have a coreir built
pip install -r ${REQUIREMENTS}

# clone other repos
git clone https://github.com/StanfordAHA/garnet
git clone --branch fix_abi https://github.com/StanfordAHA/Halide-to-Hardware

# download the prebuilt Halide library
cd Halide-to-Hardware
curl -s https://api.github.com/repos/StanfordAHA/Halide-to-Hardware/releases/latest?access_token=$GITHUB_TOKEN | grep browser_download_url | cut -d '"' -f 4 | wget -qi -
tar zxvf halide_distrib.tgz
ls distrib
cd ../

date
