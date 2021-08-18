#!/bin/bash

# Check and install requirements.
sudo pacman -S --needed \
  git \
  cmake \
  ninja \
  mingw-w64-gcc

# Clone the sources.
# Currently, we need the nightly build to successfully compile.
# v3.1.0 does not work.
git clone --depth 1 https://github.com/cginternals/glbinding.git

# Configure, build, and install.
mkdir -p build
cd build
# Installation prefix has to be provided at command line.
# Otherwise, it is not working.
cmake ../glbinding \
  -G "Ninja" \
  -DCMAKE_TOOLCHAIN_FILE=../toolchain.cmake \
  -DCMAKE_INSTALL_PREFIX=/usr/local/x86_64-w64-mingw32/
cmake --build .
sudo cmake --build . --target install

# Clean up.
cd ..
rm -rf build
rm -rf glbinding
