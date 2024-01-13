cmake_minimum_required(VERSION 3.22)

project(NoMPIDemo LANGUAGES C CXX)

enable_testing()

find_package(mpi_scalapack_stub CONFIG REQUIRED)
if(mpi_scalapack_stub_Fortran)
  enable_language(Fortran)
endif()

file(GENERATE OUTPUT .gitignore CONTENT "*")

include(CheckSourceCompiles)

add_executable(main_c main.c)
target_link_libraries(main_c PRIVATE MPI::MPI_C)
add_test(NAME MPIstubC COMMAND main_c)

add_executable(main_cpp main.cpp)
target_link_libraries(main_cpp PRIVATE MPI::MPI_CXX)
add_test(NAME MPIstubC++ COMMAND main_cpp)

if(mpi_scalapack_stub_MPI1)
  add_executable(main_fortran main.f90)
  target_link_libraries(main_fortran PRIVATE MPI::MPI_Fortran)
  add_test(NAME MPIstubFortran COMMAND main_fortran)
endif()

# --- test properties
get_property(test_names DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY TESTS)

if(CYGWIN OR WIN32)
  set_property(TEST ${test_names} PROPERTY ENVIRONMENT_MODIFICATION "PATH=path_list_append:${mpi_scalapack_stub_DIR}/../bin")
endif()
