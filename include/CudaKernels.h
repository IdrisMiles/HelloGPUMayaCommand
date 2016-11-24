#ifndef CUDAKERNELS_H
#define CUDAKERNELS_H


class CudaKernels
{
public:
    CudaKernels();
    static void VectorInc(float * vec, const unsigned int n);
};

#endif // CUDAKERNELS_H
