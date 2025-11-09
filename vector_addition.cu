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