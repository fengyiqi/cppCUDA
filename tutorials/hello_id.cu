#include <cuda.h>
#include <stdio.h>

__global__ void helloFromGPU(void) {
    const int grid_size = gridDim.x;
    const int block_size = blockDim.x;
    const int bid = blockIdx.x;
    const int tid = threadIdx.x;
    printf("Grid size %d, block size %d. Hello from block %d and thread %d!\n", grid_size, block_size, bid, tid);
}

int main() {
    helloFromGPU<<<2, 4>>>();
    cudaDeviceSynchronize();
    return 0;
}