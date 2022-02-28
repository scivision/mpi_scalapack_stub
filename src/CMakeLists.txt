add_library(mpi_c mpic.c)
target_include_directories(mpi_c INTERFACE
$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
$<INSTALL_INTERFACE:include>
)
set_target_properties(mpi_c PROPERTIES
EXPORT_NAME MPI_C
)

add_library(mpi_cxx mpic.c)
target_include_directories(mpi_cxx INTERFACE
$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
$<INSTALL_INTERFACE:include>
)
set_target_properties(mpi_cxx PROPERTIES
EXPORT_NAME MPI_CXX
)


add_library(elapse OBJECT elapse.c)
target_include_directories(elapse INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

add_library(mpi_fortran mpi.f90 $<TARGET_OBJECTS:elapse>)

if(MPI1)
  add_library(mpi_f_legacy mpi_legacy.f90)
  # use MUMPS::MPISEQ to avoid symbol clashes
endif()

if(scalapack_stub)
  add_library(scalapack scalapack.f90 blacs.f90)
endif()

install(TARGETS mpi_c mpi_cxx mpi_fortran
EXPORT ${PROJECT_NAME}-targets
)
