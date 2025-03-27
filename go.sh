#! /usr/bin/env bash
set -ex
if [ ! -d ./env ]; then
    conda create --prefix ./env python=3.12 pip python-build setuptools --yes
fi

#conda run --prefix ./env python -m pip install .
conda run --prefix ./env python -c "import c_extension; print(c_extension.multiplier(2, 3))"
