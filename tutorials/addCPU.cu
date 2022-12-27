#include <math.h>
#include <iostream>

const double EPSILON = 1.0e-15;
const double a = 1.23;
const double b = 2.34;
const double c = 3.57;

void add(const double *x, const double *y, double *z, const int N);
void check(const double *z, const int N);

int main() {
    const int N = 100000000;
    double *x = new double[N];
    double *y = new double[N];
    double *z = new double[N];

    for (int i = 0; i < N; i++) {
        x[i] = a;
        y[i] = b;
    }

    add(x, y, z, N);
    check(z, N);

    delete[] x, y, z;
    return 0;
}

void add(const double *x, const double *y, double *z, const int N) {
    for (int i = 0; i < N; i++)
        z[i] = x[i] + y[i];
}

void check(const double *z, const int N) { 
    for (int i = 0; i < N; i++) {
        if (fabs(z[i] - c) > EPSILON) {
            std::cout << "Has errors!\n";
            return;
        }
    }
    std::cout << "No errors!\n";
}