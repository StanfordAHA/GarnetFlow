#!/bin/bash -e

git clone --branch hls_hwbuffer_codegen_garnetflow_updates --depth 1 https://github.com/StanfordAHA/Halide-to-Hardware

cd Halide-to-Hardware

wget -q https://github.com/StanfordAHA/Halide-to-Hardware/releases/download/travis-docker-integration-3/halide_distrib.tgz
tar zxf halide_distrib.tgz
cd ../

date
