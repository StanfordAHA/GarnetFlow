#!/bin/bash -e

# Create environment variables
export CLANG=/usr/lib/llvm-7/bin/clang
export LLVM_CONFIG=/usr/lib/llvm-7/bin/llvm-config
export CLANG_OK=y

# Get Halide
git clone --branch hls_hwbuffer_codegen_garnetflow_updates --depth 1 https://github.com/$1
# StanfordAHA/Halide-to-Hardware
cd Halide-to-Hardware
#git checkout -qf hls_hwbuffer_codegen_garnetflow_updates
git checkout -qf $2

make -j4
make distrib

# I give up. someone else can try it.
# export RELEASE_ADDR=https://api.github.com/repos/StanfordAHA/Halide-to-Hardware/releases/latest
# curl -X GET -u $GITHUB_TOKEN:x-oauth-basic ${RELEASE_ADDR} | grep browser_download_url | cut -d '"' -f 5 | wget -qi -
#wget -q https://github.com/StanfordAHA/Halide-to-Hardware/releases/download/v0.0.8/halide_distrib.tgz
#wget -q https://github.com/StanfordAHA/Halide-to-Hardware/releases/download/test-buffer-4/halide_distrib.tgz
#wget -q https://github.com/StanfordAHA/Halide-to-Hardware/releases/download/ubuffer-abi-fix/halide_distrib.tgz
# wget -q https://github.com/StanfordAHA/Halide-to-Hardware/releases/download/ubuffer-using-llvm-7/halide_distrib.tgz
#tar zxf halide_distrib.tgz
#ls distrib
cd ../

date