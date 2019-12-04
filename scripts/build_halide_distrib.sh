#!/bin/bash -e

source install_halide_deps.sh
source install_and_build_halide.sh
#source install_and_build_halide.sh $1 $2
cd Halide-to-Hardware
rm -f distrib/halide.tgz
rm -f distrib/libHalide.so
tar -czvf halide_distrib.tgz distrib
cd ..

date
