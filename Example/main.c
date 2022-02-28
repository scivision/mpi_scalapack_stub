#include <stdio.h>
#include "mpi.h"

int main(void){

int ierr = MPI_Init (NULL, NULL );

if ( ierr != 0 )
{
  fprintf(stderr, "MPI_Init fail.\n");
  return 1;
}

ierr = MPI_Comm_size ( MPI_COMM_WORLD, &p );

ierr = MPI_Comm_rank ( MPI_COMM_WORLD, &id );

return 0;
}
