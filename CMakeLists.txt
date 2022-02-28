cmake_minimum_required(VERSION 3.15...3.23)

project(MPI
LANGUAGES C CXX Fortran
VERSION 1.0.0
)

enable_testing()

option(BUILD_TESTING "Build and run the tests" ON)
option(MPI1 "Build MPI-1 stub")
option(scalapack_stub "Build the scalapack stub")

include(cmake/options.cmake)

add_subdirectory(src)

include(cmake/install.cmake)

# FetchContent targets
add_library(MPI::MPI_C INTERFACE IMPORTED GLOBAL)
target_link_libraries(MPI::MPI_C INTERFACE mpi_c)

add_library(MPI::MPI_CXX INTERFACE IMPORTED GLOBAL)
target_link_libraries(MPI::MPI_CXX INTERFACE mpi_cxx)

add_library(MPI::MPI_Fortran INTERFACE IMPORTED GLOBAL)
target_link_libraries(MPI::MPI_Fortran INTERFACE mpi_fortran)
