#!/bin/bash

set -ex

cmake -B build ${CMAKE_ARGS} -G "Unix Makefiles" \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DCMAKE_INSTALL_LIBDIR=lib \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  -DBUILD_TEST=ON \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
  -DENABLE_POSIX_API=ON \
  -DENABLE_BINARY_COMPATIBLE_POSIX_API=ON \
  -DINSTALL_DOCUMENTATION=OFF \
  .

cmake --build build --config Release --target install

cp $SRC_DIR/test/test.sh build/test
cd build/test && ./test.sh 