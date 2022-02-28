cmake_minimum_required(VERSION 3.15...3.23)

project(NoMPIDemo LANGUAGES C CXX Fortran)

find_package(mpi_scalapack_stub CONFIG REQUIRED)

add_executable(main_c main.c)
target_link_libraries(main_c PRIVATE MPI::MPI_C)
# add_executable(main_cpp main.cpp)
# add_executable(main_fortran main.f90)
