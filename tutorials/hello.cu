#include <cuda.h>
#include <iostream>
#include <stdio.h>

__global__ void helloFromGPU(void) {
    const int bid = blockIdx.x;
    const int tid = threadIdx.x;
    // 目前我的nvcc 10.2还不支持核函数调用std函数
    printf("Hello from block %d and thread %d!\n", bid, tid);
}

class PRINT {
public:
    void print() {
        std::cout << "Hello from CPU" << std::endl;
    }
    void printGPU() {
        helloFromGPU<<<2, 4>>>();
    }
};

int main() {
    PRINT a;
    a.print();
    a.printGPU();
    cudaDeviceSynchronize();
    // cudaDeviceReset();
    return 0;
}