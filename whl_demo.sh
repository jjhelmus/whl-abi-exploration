#! /usr/bin/env bash
set -ex
if [ ! -d ./env ]; then
    conda create --prefix ./env python=3.12 pip python-build setuptools --yes
    conda run --prefix ./env python -m pip install delocate
fi

cd spam
    cc -c -fPIC foo.c
    cc -shared -o libfoo.so foo.o
    rm foo.o

    rm -rf build
    rm -rf dist
    rm -rf fixed_wheels
    conda run --prefix ../env python -m build --wheel .
    conda run --prefix ../env delocate-wheel -w fixed_wheels -v ./dist/*.whl
    conda run --prefix ../env delocate-listdeps --all fixed_wheels/*.whl
cd ..

cd eggs
    cc -c -fPIC foo.c
    cc -shared -o libfoo.so foo.o
    rm foo.o

    rm -rf build
    rm -rf dist
    rm -rf fixed_wheels
    conda run --prefix ../env python -m build --wheel .
    conda run --prefix ../env delocate-wheel -w fixed_wheels -v ./dist/*.whl
    conda run --prefix ../env delocate-listdeps --all fixed_wheels/*.whl
cd ..

conda create --prefix ./test_env python=3.12 pip --yes
conda run --prefix ./test_env python -m pip install ./spam/fixed_wheels/*.whl
conda run --prefix ./test_env python -m pip install ./eggs/fixed_wheels/*.whl
conda run --prefix ./test_env python mixed_demo.py
