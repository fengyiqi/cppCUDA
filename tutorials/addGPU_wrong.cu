#include <cuda.h>
#include <iostream>
#include "error.cuh"

const double EPSILON = 1.0e-15;
const double a = 1.23;
const double b = 2.34;
const double c = 3.57;

double __device__ add_element(const double &x, const double &y);
void __global__ add(const double *x, const double *y, double *z);
void check(const double *z, const int N);

int main() {
    const int N = 100000000;
    double *h_x = new double[N];
    double *h_y = new double[N];
    double *h_z = new double[N];

    for (int i = 0; i < N; i++) {
        h_x[i] = a;
        h_y[i] = b;
    }

    const int M = N * sizeof(double);
    double *d_x, *d_y, *d_z;
    CHECK(cudaMalloc((void **)&d_x, M));
    CHECK(cudaMalloc((void **)&d_y, M));
    CHECK(cudaMalloc((void **)&d_z, M));
    CHECK(cudaMemcpy(d_x, h_x, M, cudaMemcpyHostToDevice));
    CHECK(cudaMemcpy(d_y, h_y, M, cudaMemcpyHostToDevice));

    const int block_size = 1280;
    const int grid_size = (N + block_size - 1) / block_size;
    add<<<grid_size, block_size>>>(d_x, d_y, d_z);
    CHECK(cudaGetLastError());
    CHECK(cudaDeviceSynchronize());

    CHECK(cudaMemcpy(h_z, d_z, M, cudaMemcpyDeviceToHost));
    check(h_z, N);

    delete[] h_x, h_y, h_z;
    CHECK(cudaFree(d_x));
    CHECK(cudaFree(d_y));
    CHECK(cudaFree(d_z));

    return 0;
}

double __device__ add_element(const double &x, const double &y) {
    return x + y;
}

void __global__ add(const double *x, const double *y, double *z) {
    const int i = blockDim.x * blockIdx.x + threadIdx.x;
    // z[i] = add_element(x[i], y[i]);
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