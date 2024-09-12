#include "sayhello.cuh"

__global__ void sayHello3(int N, int *a, int *b, int *c)  // __global__ 为CUDA的关键字,表示代码在设备端(GPU端)运行, 可以在CPU端被调用
{
    for(int i = blockIdx.x * blockDim.x + threadIdx.x;  i < N; i += gridDim.x * blockDim.x)
    {
        c[i] = a[i] + b[i];
        // printf("%d %d %d\n",a[i],b[i],c[i]);
        printf("Hello CUDA!%d\n",i);
    }      
}

int callforsayHello3()
{
    int N = 2 << 3; //线程数    //16

    int *c = NULL;
    int *a = NULL;
    int *b = NULL;

    //创建stream
    cudaStream_t stream = NULL;
    cudaStreamCreate (&stream);

    //CUDA 的统一内存
    cudaMallocManaged(&a, N * sizeof(int), cudaMemAttachHost);
    cudaStreamAttachMemAsync (stream, a);
    cudaMallocManaged(&b, N * sizeof(int), cudaMemAttachHost);
    cudaStreamAttachMemAsync (stream, b);
    cudaMallocManaged(&c, N * sizeof(int), cudaMemAttachHost);
    cudaStreamAttachMemAsync (stream, c);

    // cudaMemcpyAsync(inputEC, cloudNew->points.data(), sizeof(float) * 4 * sizeEC, cudaMemcpyHostToDevice, stream);
    
    for (int i = 0; i < N; i++) {
        a[i] = i+1;
        b[i] = i*2+1;
    }
    cudaStreamSynchronize(stream);

    int blockSize = 256;
    int numBlocks = (N + blockSize - 1) / blockSize;
    sayHello3 <<<numBlocks, blockSize, 0, stream>>> (N, a, b, c);  // 函数调用,  <<< >>>中的第一个参数表示块的个数, 第二个参数表示每个线程块中线程的个数

    //5.等待设备所有线程任务执行完毕
    cudaStreamSynchronize(stream);

    std::cout << "c: " << c <<std::endl;
    for (int i = 0; i < N; i++){
        std::cout << "c["<< i <<"]: "<< c[i] <<std::endl;
    }
    
    cudaStreamDestroy(stream);
    cudaFree(c);
    cudaFree(a);
    cudaFree(b);
    return 0;
}
