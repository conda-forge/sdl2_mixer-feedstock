#!/bin/bash
set -ex

mkdir build
cd build

cmake -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DSDL2MIXER_VENDORED=OFF \
    # no modplug/libxmp in conda-forge yet
    -DSDL2MIXER_MOD_MODPLUG=OFF \
    -DSDL2MIXER_MOD_XMP=OFF \
    ..

cmake --build .
cmake --install --prefix $PREFIX
