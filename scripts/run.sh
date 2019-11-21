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
    export WIDTH=12
    export HEIGHT=12
fi

# build CGRA
make garnet_verilog

if [ -n "$BUILDKITE" ] && [ -z "$PR" ];
then
    make gaussian
    make cascade
    make harris
    make conv_3_3
fi

# build apps
make conv_1_2
make conv_2_1
make absolute
make pointwise
make scomp
make ucomp
make uminmax
make rom
make ushift
make arith


