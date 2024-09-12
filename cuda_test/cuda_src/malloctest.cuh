#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>
#include <stdio.h>

__global__ void sayHello2(int N, int *a, int *b, int *c);
int callforsayHello2();