#!/bin/bash -e

# Make sure we are using python3 for everything
update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Install dependencies use latest H2H?
source install_halide_deps.sh
source install_garnet.sh
source install_pre_built_halide.sh

date
