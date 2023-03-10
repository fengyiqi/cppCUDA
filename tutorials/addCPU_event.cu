#include <math.h>
#include <iostream>
#include "error.cuh"

#ifdef USE_DP
    typedef double real;
    const real EPSILON = 1.0e-15;
#else
    typedef float real;
    const real EPSILON = 1.0e-6f;
#endif

const int NUM_REPEATS = 11;
const real a = 1.23;
const real b = 2.34;
const real c = 3.57;

void add(const real *x, const real *y, real *z, const int N);
void check(const real *z, const int N);

int main() {
    const int N = 100000000;
    real *x = new real[N];
    real *y = new real[N];
    real *z = new real[N];

    for (int i = 0; i < N; i++) {
        x[i] = a;
        y[i] = b;
    }

    float t_sum = 0;
    float t2_sum = 0;
    int count = 0;
    for (int i = 0; i < NUM_REPEATS; i++) {
        cudaEvent_t start, stop;
        CHECK(cudaEventCreate(&start));
        CHECK(cudaEventCreate(&stop));
        CHECK(cudaEventRecord(start));
        cudaEventQuery(start);

        add(x, y, z, N);

        CHECK(cudaEventRecord(stop));
        CHECK(cudaEventSynchronize(stop));

        float elapsed_time;
        CHECK(cudaEventElapsedTime(&elapsed_time, start, stop));
        printf("Trial %d: time = %g ms.\n", count, elapsed_time);

        if (i > 0) {
            t_sum += elapsed_time;
            t2_sum += elapsed_time * elapsed_time;
        }

        CHECK(cudaEventDestroy(start));
        CHECK(cudaEventDestroy(stop));
        count += 1;
    }
    
    const float t_ave = t_sum / (count - 1);
    const float t_err = sqrt(t2_sum / (count - 1) - t_ave * t_ave);
    printf("Average: time = %g +- %g ms.\n", t_ave, t_err);
    
    check(z, N);

    delete[] x, y, z;
    return 0;
}

void add(const real *x, const real *y, real *z, const int N) {
    for (int i = 0; i < N; i++)
        z[i] = x[i] + y[i];
}

void check(const real *z, const int N) { 
    for (int i = 0; i < N; i++) {
        if (fabs(z[i] - c) > EPSILON) {
            std::cout << "Has errors!\n";
            return;
        }
    }
    std::cout << "No errors!\n";
}