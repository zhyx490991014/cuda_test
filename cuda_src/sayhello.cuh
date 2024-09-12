#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>
#include <stdio.h>

__global__ void sayHello(int *a, int *b, int *c);
int callforsayHello();