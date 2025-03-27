int
get_version() {
    return 2;
}

int
doit(int a, int b, int c)
{
    if (c == 1) {
        return a * b;
    } else {
        return a + b;
    }
}
