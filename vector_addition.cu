// Headers
#include <iostream>
#include <stdio.h>

// Prototypes of GPU kernels
__global__ void gpu_print_thread_id();
__global__ void gpu_vector_add( const unsigned int size, float *dev_a, float *dev_b, float *dev_c );

// Prototypes of HOST functions
void *gpu_mem_alloc( void *host_p, const unsigned int bytes );
void stop( const std::string &error_msg );

// Main
int main()
{
  // Define the size of the problem and the total amount of required memory
  const unsigned int size = 1 << 16;

  const unsigned int bytes = sizeof(float) * size;

  std::cout << "number of vectors for the addition problem: 3\n";
  std::cout << "vector size is equal to: " << size << '\n';
  std::cout << "vector size in bytes is equal to: " << bytes << '\n';
  std::cout << "total amount of required memory (bytes): " << 3 * bytes << '\n';
}

// GPU kernel definitions
__global__ void gpu_vector_add( unsigned int size, float *dev_a, float *dev_b, float *dev_c )
{
  int thread_id = blockDim.x * blockIdx.x + threadIdx.x;

  if ( thread_id < size )
  {
    dev_c[thread_id] = d_a[thread_id] + d_b[thread_id];
  }
}

__global__ void gpu_print_thread_id()
{
  printf( "blockID: %u, threadId: %d\n", blockIdx.x, threadIdx.x );
}

// Host function definitions
void *gpu_mem_alloc( void *host_p, const unsigned int bytes)
{
  void *dev_p = NULL;
  cudaError_t status = cudaMalloc( &dev_p, bytes );
  if ( status != cudaSuccess ) stop("ERROR: CUDA MEMORY ALLOCATION FAILED! -> TYPE 1");

  status = cudaMemCpy( dev_p, host_p, bytes, cudeMemcpyHostToDevice );
  if ( status != cudaSuccess ) stop("ERROR: CUDA MEMORY ALLOCATION FAILED! -> TYPE 2");
}

void stop( const std::string &error_message )
{
  std::cerr << error_message << '\n';
  exit(1);
}