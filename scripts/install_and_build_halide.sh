#!/bin/bash -e

if [ ! -d "/usr/lib/llvm-7" ]; then
	apt-get --assume-yes install llvm-7
	apt-get --assume-yes install clang-7
else
	echo "llvm already installed"
fi

# Create environment variables
export CLANG=/usr/lib/llvm-7/bin/clang
export LLVM_CONFIG=/usr/lib/llvm-7/bin/llvm-config
export CLANG_OK=y

# Get Halide
cd Halide-to-Hardware

if [[ -z $Halide_to_Hardware ]]; then
  make -j4
  make distrib
else
  git checkout $Halide_to_Hardware
  make -j4
  make distrib
fi

cd ../

date
