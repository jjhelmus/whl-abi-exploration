#! /usr/bin/env bash
set -ex

conda create --name build python=3.12 pip python-build setuptools patchelf --yes
conda run --name build python -m pip install auditwheel

cd spam
    cc -c -fPIC foo.c
    cc -shared -o libfoo.so foo.o
    rm foo.o

    rm -rf build
    rm -rf dist
    rm -rf wheelhouse
    conda run --name build python -m build --wheel .
    conda run --name build auditwheel show ./dist/*.whl
    conda run --name build LD_LIBRARY_PATH=$(pwd) auditwheel repair dist/*.whl
    conda run --name build auditwheel show ./wheelhouse/*.whl
cd ..

cd eggs
    cc -c -fPIC foo.c
    cc -shared -o libfoo.so foo.o
    rm foo.o

    rm -rf build
    rm -rf dist
    rm -rf wheelhouse
    conda run --name build python -m build --wheel .
    conda run --name build auditwheel show ./dist/*.whl
    conda run --name build LD_LIBRARY_PATH=$(pwd) auditwheel repair dist/*.whl
    conda run --name build auditwheel show ./wheelhouse/*.whl
cd ..

conda create --name test_env python=3.12 pip --yes
conda run --name test_env python -m pip install ./spam/wheelhouse/*.whl
conda run --name test_env python -m pip install ./eggs/wheelhouse/*.whl
conda run --name test_env python mixed_demo.py
