// lazy_placement_demo.cpp
int lazy_demo(int a, int b, int c, int cond, int n) {
    int result = 0;
    for (int i = 0; i < n; i++) {
        result += c;
        if (cond) {
            result += a * b;   // only computed on this path
        }
    }
    return result;
}
