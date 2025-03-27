#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <stdio.h>
#include "foo.h"

static PyObject *
eggs_get_libfoo_version(PyObject *self, PyObject *args)
{
    int ret;
    ret = get_version();
    return Py_BuildValue("i", ret);
}

static PyObject *
eggs_doit(PyObject *self, PyObject *args)
{
    int a;
    int b;
    int ret;
    if (!PyArg_ParseTuple(args, "ii", &a, &b))
    {
        return NULL;
    }
    ret = doit(a, b, 1);
    return Py_BuildValue("i", ret);
}

static PyMethodDef EggsMethods[] = {
        {"doit", eggs_doit, METH_VARARGS, "Do the thing."},
        {"get_libfoo_version", eggs_get_libfoo_version, METH_VARARGS, "Return str of libfoo version."},
        {NULL, NULL, 0, NULL}
};

static struct PyModuleDef eggsmodule =
    {
        PyModuleDef_HEAD_INIT,
        "spam",
        "An example module that links against libfoo",
        -1,
        EggsMethods
    };

PyMODINIT_FUNC
PyInit_eggs(void)
{
    return PyModule_Create(&eggsmodule);
}
