from setuptools import setup, Extension

setup(
    name="spam",
    version="0.1",
    description="An example extension that links against libfoo.",
    ext_modules = [Extension(
        "spam",
        sources=["spam.c"],
        include_dirs=["./"],
        libraries=["foo"],
        library_dirs=["./"],
    )],
)
