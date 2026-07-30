// phi_overhead_demo.cpp
int phi_demo(int a, int b, int x, int y, int z, int cond1, int cond2) {
    int val;
    if (cond1) {
        if (cond2) {
            val = a * b + x;
        } else {
            val = a * b + y;
        }
    } else {
        val = a * b + z;
    }
    return val * (a * b);
}
