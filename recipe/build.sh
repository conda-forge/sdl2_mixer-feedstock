#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./build-scripts
set -ex

mkdir build
cd build

# no modplug/libxmp in conda-forge yet
cmake ${CMAKE_ARGS} -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DBUILD_SHARED_LIBS=ON \
    -DSDL2MIXER_VENDORED=OFF \
    -DSDL2MIXER_MOD_MODPLUG=OFF \
    -DSDL2MIXER_MOD_XMP=OFF \
    ..

cmake --build .
cmake --install . --prefix $PREFIX
