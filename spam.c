#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include "foo.h"

static PyObject *
spam_doit(PyObject *self, PyObject *args)
{
    int a;
    int b;
    int ret;
    if (!PyArg_ParseTuple(args, "ii", &a, &b))
    {
        return NULL;
    }
    ret = doit(a, b);
    return Py_BuildValue("i", ret);
}

static PyMethodDef SpamMethods[] = {
        {"doit", spam_doit, METH_VARARGS, "Do the thing."},
        {NULL, NULL, 0, NULL}
};

static struct PyModuleDef spammodule =
    {
        PyModuleDef_HEAD_INIT,
        "spam",
        "An example module that links against libfoo",
        -1,
        SpamMethods
    };

PyMODINIT_FUNC
PyInit_spam(void)
{
    return PyModule_Create(&spammodule);
}
