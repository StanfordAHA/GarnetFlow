#!/bin/bash -e

SOURCE="${BASH_SOURCE[0]}"
REQUIREMENTS=`(dirname ${SOURCE})`/requirements.txt

if [ ! -d "/usr/lib/llvm-7" ]; then
	apt-get --assume-yes install llvm-7
	apt-get --assume-yes install clang-7
else
	echo "llvm already installed"
fi

# If coreir has not already been built
if [ ! -d "coreir" ]; then
	# test of push ability
	# build coreir here
	#git clone --depth 1 --branch rm-ubuf https://github.com/rdaly525/coreir coreir
	git clone --depth 1 --branch ubuffer https://github.com/rdaly525/coreir coreir
	# there is a bug in ABI with regex
	# see https://github.com/rdaly525/coreir/issues/737
	#cd coreir && \
	#git apply /GarnetFlow/patches/coreir_path_cxxopt && \
	#cd ..
	cd coreir/build && cmake .. && make -j4 && cd ../../
else
	echo "Coreir already built"
fi

# pin pycoreir version since the latest one doesn't work
pip3 install --ignore-installed coreir==2.0.19

# install this last since we already have a coreir built
python3 python_repo.py

# install genesis2
pip3 install genesis2

# clone garnet
git clone --depth 1 https://github.com/StanfordAHA/garnet

# create the lake repo
export COREIR_DIR=/GarnetFlow/scripts/coreir # lake needs to know where coreir is
git clone --branch master --depth 1 https://github.com/joyliu37/BufferMapping
cd BufferMapping/cfunc
make lib
cd ../../

date
