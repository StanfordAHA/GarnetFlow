#!/bin/bash -e

if [ -n "$PR" ];
then
    # people who maintain lassen love one-line commits
    # and file PR before the branch is working.
    # need to setup special tests for them
    export WIDTH=8
    export HEIGHT=6
elif [ -n "$BUILDKITE" ];
then
    export WIDTH=32
    export HEIGHT=16
else
    export WIDTH=7
    export HEIGHT=6
fi

# build CGRA
make garnet_verilog

# build apps
make pointwise
make conv_1_2
make conv_2_1
make scomp
make ucomp
make arith
make ushift
make uminmax
make rom

if [ -n "$BUILDKITE" ] && [ -z "$PR" ];
then
    make conv_3_3
    make gaussian
    make cascade
    make harris
fi
