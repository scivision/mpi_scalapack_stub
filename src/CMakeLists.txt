add_library(elapse OBJECT elapse.c)
target_include_directories(elapse INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

if(MPI1)
  add_library(mpi_f_legacy mpi_legacy.f90)
  # use MUMPS::MPISEQ to avoid symbol clashes
endif()

if(scalapack_stub)
  add_library(scalapack scalapack.f90 blacs.f90)
endif()
