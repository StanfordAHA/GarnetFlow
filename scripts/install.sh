#!/bin/bash -e

# Make sure we are using python3 for everything
update-alternatives --install /usr/bin/python python /usr/bin/python3 1
# Install dependencies
source install_halide_deps.sh
source install_and_build_halide.sh

date
