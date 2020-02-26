#!/bin/bash -xe

if [[ -z $PR ]]; then
  git clone https://github.com/StanfordAHA/Halide-to-Hardware
  ./install_and_build_halide.sh
else
  git clone --depth 1 https://github.com/StanfordAHA/Halide-to-Hardware
  cd Halide-to-Hardware

  wget -q https://github.com/StanfordAHA/Halide-to-Hardware/releases/download/lakelib/halide_distrib.tgz
  tar zxf halide_distrib.tgz
fi

cd ../

date
