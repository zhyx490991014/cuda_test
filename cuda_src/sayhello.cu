#include "sayhello.cuh"

__global__ void sayHello(int *a, int *b, int *c)  // __global__ 为CUDA的关键字,表示代码在设备端(GPU端)运行, 可以在CPU端被调用
{
    for(int i = blockIdx.x * blockDim.x + threadIdx.x;  i < 1; i += gridDim.x * blockDim.x)
    {
        *c = *a + *b;
        printf("Hello CUDA!%d\n",i);
    }      
}

int callforsayHello()
{
    int c =0, a = 1, b = 2;

    int *dev_c = 0;
    int *dev_a = 0;
    int *dev_b = 0;
    //3.请求CUDA设备的内存（显存），执行CUDA函数
    cudaMalloc((void**)&dev_c, sizeof(int));
    cudaMalloc((void**)&dev_a, sizeof(int));
    cudaMalloc((void**)&dev_b, sizeof(int));

    //4.从主机复制数据到设备上
    cudaMemcpy(dev_a, &a, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, &b, sizeof(int), cudaMemcpyHostToDevice);

    int N = 100;
    sayHello <<<(N+9)/10, 10 >>> (dev_a, dev_b, dev_c);  // 函数调用,  <<< >>>中的第一个参数表示块的个数, 第二个参数表示每个线程块中线程的个数

    //5.等待设备所有线程任务执行完毕
    cudaDeviceSynchronize();

    //6.数据复制到主机，释放占用空间
    cudaMemcpy(&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost);
    std::cout<< "&c: " <<&c<<std::endl;
    std::cout<< "dev_c: "<<dev_c<<std::endl;
    std::cout << "c: "<<c<<std::endl;

    cudaFree(dev_c);
    cudaFree(dev_a);
    cudaFree(dev_b);
    return 0;
}
