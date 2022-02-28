cmake_minimum_required(VERSION 3.15...3.23)

project(NoMPIDemo LANGUAGES C CXX Fortran)

enable_testing()

find_package(mpi_scalapack_stub CONFIG REQUIRED)

add_compile_options($<$<COMPILE_LANGUAGE:C,CXX>:-Werror>)

add_executable(main_c main.c)
target_link_libraries(main_c PRIVATE MPI::MPI_C)
add_test(NAME MPIstubC COMMAND main_c)

add_executable(main_cpp main.cpp)
target_link_libraries(main_cpp PRIVATE MPI::MPI_CXX)
add_test(NAME MPIstubC++ COMMAND main_cpp)

# add_executable(main_fortran main.f90)
