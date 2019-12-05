#!/bin/bash -e

git clone --depth 1 https://github.com/StanfordAHA/Halide-to-Hardware
cd Halide-to-Hardware

wget -q https://github.com/StanfordAHA/Halide-to-Hardware/releases/download/cascade-cast-issue-resolved/halide_distrib.tgz
tar zxf halide_distrib.tgz
cd ../

date
