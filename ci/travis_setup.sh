#!/bin/bash

# Originally written for Chemfiles <https://github.com/chemfiles/chemfiles> by
# Guillaume Fraux.  For documentation, bug reports, support requests,
# etc. please use <https://github.com/nemequ/icc-travis>.

export CMAKE_ARGS="-DCMAKE_BUILD_TYPE=Debug -DINCHI_BUILD_SHARED=ON -DINCHI_BUILD_EXE=ON -DINCHI_DEMOS=ON -DINCHI_TESTING=ON -DRINCHI_TESTING=ON"

if [[ "$EMSCRIPTEN" == "ON" ]]; then
    # Install a Travis compatible emscripten SDK
    wget https://github.com/chemfiles/emscripten-sdk/archive/master.tar.gz
    tar xf master.tar.gz
    ./emscripten-sdk-master/emsdk activate
    source ./emscripten-sdk-master/emsdk_env.sh

    export CMAKE_CONFIGURE='emcmake'
    export CMAKE_ARGS="-DINCHI_TESTING=ON -DTEST_RUNNER=node -DCMAKE_BUILD_TYPE=Release"

    # Install a modern cmake
    cd $HOME
    wget https://cmake.org/files/v3.9/cmake-3.9.3-Linux-x86_64.tar.gz
    tar xf cmake-3.9.3-Linux-x86_64.tar.gz
    export PATH=$HOME/cmake-3.9.3-Linux-x86_64/bin:$PATH

    export CC=emcc
    export CXX=em++

    return
fi

if [[ "$VALGRIND" == "ON" ]]; then
    export CMAKE_ARGS="$CMAKE_ARGS -DTEST_RUNNER=valgrind"
fi

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    if [[ "$CC" == "gcc" ]]; then
        export CC=gcc
        export CXX=g++
    fi
fi

if [[ "$USE_ICC" == "ON" ]]; then
    /bin/sh $TRAVIS_BUILD_DIR/ci/install-icc.sh
    source ~/.bashrc
    export CC=icc
    export CXX=icpc
fi

if [[ "$USE_PGI" == "ON" ]]; then
    /bin/sh $TRAVIS_BUILD_DIR/ci/install-pgi.sh
    export CC=pgcc
    export CXX=pgc++
    export CMAKE_ARGS="-DCMAKE_BUILD_TYPE=Debug -DINCHI_BUILD_SHARED=ON -DINCHI_BUILD_EXE=ON -DINCHI_DEMOS=ON -DINCHI_TESTING=ON"
fi

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    brew update
fi

if [[ "$ARCH" == "x86" ]]; then
    export CMAKE_ARGS="$CMAKE_ARGS -DCMAKE_CXX_FLAGS=-m32 -DCMAKE_C_FLAGS=-m32"
fi
