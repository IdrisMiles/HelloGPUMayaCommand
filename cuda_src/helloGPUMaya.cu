#include "../include/CudaKernels.h"

// CUDA includes
#include <cuda_runtime.h>
#include <thrust/device_vector.h>


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
    thrust::device_vector<float> d_vec(vec, vec+n);
    float * d_vec_ptr = thrust::raw_pointer_cast(&vec[0]);

    unsigned int blockSize = 1024;
    unsigned int gridSize = iDivUp(n, blockSize);
    cuVectorInc<<<gridSize, blockSize>>>(d_vec_ptr, n);
    cudaThreadSynchronize();

    thrust::copy(d_vec.begin(), d_vec.end(), vec);
}
