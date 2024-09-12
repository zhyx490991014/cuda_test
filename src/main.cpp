#include "cuda_src/sayhello.cuh"
#include "cuda_src/malloctest.cuh"
#include "cuda_src/streamtest.cuh"


int main()
{
    int a = 1;
    std::cout <<"main: &a = "<< &a <<std::endl;

    std::cout << "*****sayhello*****"<<std::endl;
    callforsayHello();

    std::cout << std::endl <<"****malloctest****"<<std::endl;
    callforsayHello2();

    std::cout << std::endl <<"****streamtest****"<<std::endl;
    callforsayHello3();
    return 0;
}
