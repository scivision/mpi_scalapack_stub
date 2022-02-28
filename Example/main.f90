program mpi_stub

use mpi

implicit none (type, external)

external :: mpi_finalize

integer :: ierr, Nmpi, id

call mpi_init(ierr)
if (ierr /= 0) error stop 'mpi_init failed'

call MPI_Comm_size(MPI_COMM_WORLD, Nmpi, ierr)

call MPI_Comm_rank(MPI_COMM_WORLD, id, ierr)

if (Nmpi /= 1) error stop 'MPI_COMM_SIZE /= 1'
if (id /= 0) error stop 'MPI_COMM_RANK /= 0'

call MPI_Finalize(ierr)

if(ierr /= 0) error stop 'mpi_finalize failed'

end program
