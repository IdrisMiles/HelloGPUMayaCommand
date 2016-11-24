#include "../include/CudaKernels.h"

// CUDA includes
#include <cuda_runtime.h>
//#include <cuda.h>
//#include <cuda_runtime_api.h>
//#include <device_functions.h>


unsigned int iDivUp(unsigned int a, unsigned int b)
{
    uint c = a/b;
    c += (a%b == 0) ? 0: 1;
    return c;
}


__global__ void cuVectorInc(float * vec, const unsigned int n)
{
    unsigned int  idx = threadIdx.x + (blockIdx.x * blockDim.x);

    if(idx < n)
    {
        atomicAdd(&vec[idx], 1);
    }
}




void CudaKernels::VectorInc(float * vec, const unsigned int n)
{
    unsigned int blockSize = 1024;
    unsigned int gridSize = iDivUp(n, blockSize);
    cuVectorInc<<<gridSize, blockSize>>>(vec, n);
}
