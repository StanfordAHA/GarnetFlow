#!/bin/bash -e

update-alternatives --install /usr/bin/python python /usr/bin/python3 1
source install_halide_deps.sh
source install_and_build_halide.sh

date
