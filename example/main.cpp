#include <iostream>

#include "mpi.h"

int main(){
int id, Nmpi;

if (MPI_Init (NULL, NULL)){
  std::cerr << "MPI_Init fail." << std::endl;
  return EXIT_FAILURE;
}

if (MPI_Comm_size(MPI_COMM_WORLD, &Nmpi) != 0){
  std::cerr << "MPI_Comm_size fail." << std::endl;
  return EXIT_FAILURE;
}

if (MPI_Comm_rank(MPI_COMM_WORLD, &id) != 0){
  std::cerr << "MPI_Comm_rank fail." << std::endl;
  return EXIT_FAILURE;
}

if(Nmpi != 1) {
  std::cerr << "MPI_Comm_size != 1." << std::endl;
  return EXIT_FAILURE;
}

if(id != 0) {
  std::cerr << "MPI_Comm_rank != 0." << std::endl;
  return EXIT_FAILURE;
}

if (MPI_Finalize() != 0){
  std::cerr << "MPI_Finalize fail." << std::endl;
  return EXIT_FAILURE;
}

return EXIT_SUCCESS;
}
