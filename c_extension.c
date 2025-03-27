#define PY_SSIZE_T_CLEAN
#include <Python.h>

int
multiplier(int a, int b)
{
    return a * b;
}

static PyObject *
c_multiplier(PyObject *self, PyObject *args)
{
    int a;
    int b;
    int ret;
    if (!PyArg_ParseTuple(args, "ii", &a, &b))
    {
        return NULL;
    }
    ret = multiplier(a, b);
    return Py_BuildValue("i", ret);
}

static PyMethodDef
module_methods[] = {
        {"multiplier", c_multiplier, METH_VARARGS, "Multiply two numbers."},
        {NULL, NULL, 0, NULL}
};

static struct PyModuleDef c_extension =
    {
        PyModuleDef_HEAD_INIT,
        "c_extension", // the name of the module in Python
        "",            // The docstring in Python
        -1,            /* size of per-interpreter state of the module, or -1 if the module keeps state in global variables. */
        module_methods
    };

PyMODINIT_FUNC
PyInit_c_extension(void)
{
    return PyModule_Create(&c_extension);
}
