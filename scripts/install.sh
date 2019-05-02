#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
REQUIREMENTS=`(dirname ${SOURCE})`/requirements.txt
pip install -r ${REQUIREMENTS}

# clone other repos
git clone https://github.com/StanfordAHA/garnet
git clone https://github.com/StanfordAHA/Halide-to-Hardware

# download the prebuilt Halide library
cd Halide-to-Hardware
curl -s https://api.github.com/repos/StanfordAHA/Halide-to-Hardware/releases/latest?access_token=$GITHUB_TOKEN | grep browser_download_url | cut -d '"' -f 4 | wget -qi -
tar zxvf halide_distrib.tgz
ls distrib
cd ../

date
