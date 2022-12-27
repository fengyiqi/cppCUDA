#include <cuda.h>
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

void __global__ add(const real *x, const real *y, real *z);
void check(const real *z, const int N);

int main() {
    const int N = 100000000;
    real *h_x = new real[N];
    real *h_y = new real[N];
    real *h_z = new real[N];

    for (int i = 0; i < N; i++) {
        h_x[i] = a;
        h_y[i] = b;
    }

    const int M = N * sizeof(real);
    real *d_x, *d_y, *d_z;
    CHECK(cudaMalloc((void **)&d_x, M));
    CHECK(cudaMalloc((void **)&d_y, M));
    CHECK(cudaMalloc((void **)&d_z, M));
    CHECK(cudaMemcpy(d_x, h_x, M, cudaMemcpyHostToDevice));
    CHECK(cudaMemcpy(d_y, h_y, M, cudaMemcpyHostToDevice));

    const int block_size = 128;
    const int grid_size = (N + block_size - 1) / block_size;

    float t_sum = 0;
    float t2_sum = 0;
    int count = 0;
    for (int i = 0; i < NUM_REPEATS; i++) {
        cudaEvent_t start, stop;
        CHECK(cudaEventCreate(&start));
        CHECK(cudaEventCreate(&stop));
        CHECK(cudaEventRecord(start));
        cudaEventQuery(start);

        add<<<grid_size, block_size>>>(d_x, d_y, d_z);

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

    CHECK(cudaMemcpy(h_z, d_z, M, cudaMemcpyDeviceToHost));
    check(h_z, N);

    delete[] h_x, h_y, h_z;
    CHECK(cudaFree(d_x));
    CHECK(cudaFree(d_y));
    CHECK(cudaFree(d_z));

    return 0;
}


void __global__ add(const real *x, const real *y, real *z) {
    const int i = blockDim.x * blockIdx.x + threadIdx.x;
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