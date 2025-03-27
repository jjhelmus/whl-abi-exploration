#! /usr/bin/env bash
set -ex
if [ ! -d ./env ]; then
    conda create --prefix ./env python=3.12 pip python-build setuptools --yes
fi

cd spam
    cc -c -fPIC foo.c
    cc -shared -o libfoo.so foo.o
    rm foo.o

    rm -rf build
cd ..
conda run --prefix ./env python -m pip install ./spam
conda run --prefix ./env DYLD_LIBRARY_PATH=./spam python demo.py

cd eggs
    cc -c -fPIC foo.c
    cc -shared -o libfoo.so foo.o
    rm foo.o

    rm -rf build
cd ..
conda run --prefix ./env python -m pip install ./eggs
conda run --prefix ./env DYLD_LIBRARY_PATH=./eggs python demo2.py
