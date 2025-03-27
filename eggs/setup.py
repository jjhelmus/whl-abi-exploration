from setuptools import setup, Extension

setup(
    name="eggs",
    version="0.1",
    description="Another sample extension that links against libfoo.",
    ext_modules = [Extension(
        "eggs",
        sources=["eggs.c"],
        include_dirs=["./"],
        libraries=["foo"],
        library_dirs=["./"],
        extra_link_args=["-flat_namespace"],
    )],
)
