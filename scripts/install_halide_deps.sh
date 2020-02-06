#!/bin/bash -e

SOURCE="${BASH_SOURCE[0]}"
REQUIREMENTS=`(dirname ${SOURCE})`/requirements.txt

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

# create the lake repo
export COREIR_DIR=/GarnetFlow/scripts/coreir # lake needs to know where coreir is
if [ ! -d "BufferMapping" ]; then
git clone --branch master https://github.com/joyliu37/BufferMapping
cd BufferMapping
git checkout bb94e98930d1c139a599e16a66d9a810f58912f6
cd ..
cd BufferMapping/cfunc
make lib
cd ../../
fi

date
