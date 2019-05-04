#!/bin/bash -e

export COREIR_DIR=/GarnetFlow/pycoreir/coreir-cpp
export OUTPUT_REDIRECTION=""

# add Genesis to the path
export GENESIS_HOME=`pwd`/Genesis2/Genesis2Tools
export PATH=$GENESIS_HOME/bin:$GENESIS_HOME/gui/bin:$PATH
export PERL5LIB=$GENESIS_HOME/PerlLibs/ExtrasForOldPerlDistributions:$PERL5LIB

# build CGRA
make pointwise
