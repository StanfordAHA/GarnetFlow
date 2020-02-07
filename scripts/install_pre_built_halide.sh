#!/bin/bash -xe

if [[ -z $Halide_to_Hardware ]]; then
  git clone --depth 1 https://github.com/StanfordAHA/Halide-to-Hardware
  cd Halide-to-Hardware

  wget -q https://github.com/StanfordAHA/Halide-to-Hardware/releases/download/lakelib/halide_distrib.tgz
  tar zxf halide_distrib.tgz
else
  git clone https://github.com/StanfordAHA/Halide-to-Hardware
  ./install_and_build_halide.sh
fi

cd ../

date
