#include <stdio.h>

#include "mpi.h"

int main(void){
int id, Nmpi;

if (MPI_Init (NULL, NULL)){
  fprintf(stderr, "MPI_Init fail.\n");
  return 1;
}

if (MPI_Comm_size(MPI_COMM_WORLD, &Nmpi) != 0){
  fprintf(stderr, "MPI_Comm_size fail.\n");
  return 1;
}

if (MPI_Comm_rank(MPI_COMM_WORLD, &id) != 0){
  fprintf(stderr, "MPI_Comm_rank fail.\n");
  return 1;
}

if(Nmpi != 1) {
  fprintf(stderr, "MPI_Comm_size != 1.\n");
  return 1;
}

if(id != 0) {
  fprintf(stderr, "MPI_Comm_rank != 0.\n");
  return 1;
}

if (MPI_Finalize() != 0){
  fprintf(stderr, "MPI_Finalize fail.\n");
  return 1;
}

return 0;
}
