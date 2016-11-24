#include "../include/helloGPUMaya.h"

// CUDA includes
#include <cuda_runtime.h>
#include <cuda.h>
#include <cuda_runtime_api.h>
#include <device_functions.h>

__global__ void cuVectorInc(float * vec, const uint n)
{
    uint idx = threadIdx.x + (blockIdx.x * blockDim.x);

    if(idx < n)
    {
        atomicAdd(&vec[idx], 1);
    }
}
