#!/bin/bash -e

export COREIR_DIR=/GarnetFlow/scripts/coreir
export OUTPUT_REDIRECTION=""
export USE_CXX11_ABI=0

if [ -n "$BUILDKITE" ];
then
    export WIDTH=16
    export HEIGHT=16
else
    export WIDTH=10
    export HEIGHT=9
fi

# build CGRA
make garnet_verilog

# build apps
make pointwise
make conv_1_2
make conv_2_1
# disable gaussian for now
make conv_3_3

if [ -n "$BUILDKITE" ];
then
    make gaussian
    make cascade
fi
