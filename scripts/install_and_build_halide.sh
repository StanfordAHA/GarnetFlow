#!/bin/bash -e

# Create environment variables
export CLANG=/usr/lib/llvm-7/bin/clang
export LLVM_CONFIG=/usr/lib/llvm-7/bin/llvm-config
export CLANG_OK=y

# Get Halide
git clone --branch hls_hwbuffer_codegen_garnetflow_updates --depth 1 https://github.com/$1
cd Halide-to-Hardware
git checkout -qf $2

make -j4
make distrib

cd ../

date
