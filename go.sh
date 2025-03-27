#! /usr/bin/env bash
set -ex
if [ ! -d ./env ]; then
    conda create --prefix ./env python=3.12 pip python-build setuptools --yes
fi


cc -c -fPIC foo.c
cc -shared -o libfoo.so foo.o
rm foo.o

rm -rf build
conda run --prefix ./env python -m pip install .
conda run --prefix ./env python -c "import spam; print(spam.doit(2, 3))"
