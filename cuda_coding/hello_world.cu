#include<stdio.h>
__global__ void hello_from_gpu(){

    printf("Hello World from block %d and thread (%d-%d)\n",blockIdx.x,threadIdx.x,threadIdx.y);
}
int main(){
    const dim3 block_size(2,4);
    hello_from_gpu<<<1,block_size>>>();
    /*
    一块GPU中有很多计算核心，可以支持很多线程（thread）。主机在调用一个核函数时
    必须指明需要在设备中指派多少个线程，否则设备不知道如何工作。三括号中的数就是
    用来指明核函数中的线程数目及排列情况的。
    核函数中的线程常组织为若干线程块（threadblock）:三括号中的第一个数字可以看作
    线程块的个数，第二个数字可以看作每个线程块中的线程数。一个核函数的全部线程块
    构成一个网格（grid），而线程块的个数就记为网格大小（grid size）。每个线程块中
    含有同样数目的线程，该数目称为线程块大小（blocksize）。所以核函数中总的线程数
    就等于网格大小乘以线程块大小，而三括号中的两个数字分别为网格大小和线程块大小，
    即＜＜＜网格大小，线程块大小＞＞＞。所以,在上述程序中，主机只指派了设备的一个线程，
    网格大小和线程块大小都是1,即1×1＝1
    */
    cudaDeviceSynchronize();
    /*
    调用输出函数时，输出流是先存放在缓冲区的，而缓冲区不会自动刷新。只有程序遇到某种同步
    操作时缓冲区才会刷新。函数 cudaDeviceSynchronize()的作用是同步主机与设备，所以能够
    促使缓冲区刷新。
    */
    return 0;
}