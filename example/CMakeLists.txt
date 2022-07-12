cmake_minimum_required(VERSION 3.19...3.24)

project(NoMPIDemo LANGUAGES C CXX)

enable_testing()

option(fortran "enable MPI::MPI_Fortran" ON)

include(CheckSourceCompiles)
include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/DllTestPath.cmake)

find_package(mpi_scalapack_stub CONFIG REQUIRED)
if(TARGET MPI::MPI_Fortran)
  enable_language(Fortran)
endif()

add_compile_options($<$<COMPILE_LANGUAGE:C,CXX>:$<IF:$<BOOL:${MSVC}>,/WX,-Werror>>)

add_executable(main_c main.c)
target_link_libraries(main_c PRIVATE MPI::MPI_C)
add_test(NAME MPIstubC COMMAND main_c)
dll_test_path(MPI::MPI_C "MPIstubC")

add_executable(main_cpp main.cpp)
target_link_libraries(main_cpp PRIVATE MPI::MPI_CXX)
add_test(NAME MPIstubC++ COMMAND main_cpp)
dll_test_path(MPI::MPI_CXX "MPIstubC++")

if(fortran)
  set(CMAKE_REQUIRED_LIBRARIES MPI::MPI_Fortran)
  check_source_compiles(Fortran
  "program a
  implicit none (type, external)
  external :: mpi_finalize
  integer :: ierr
  call mpi_finalize(ierr)
  end program"
  HAS_MPI_FINALIZE
  )
  if(NOT HAS_MPI_FINALIZE)
    message(FATAL_ERROR "Build MPI_scalapack_stub with option -DMPI1=on")
  endif()

  add_executable(main_fortran main.f90)
  target_link_libraries(main_fortran PRIVATE MPI::MPI_Fortran)
  add_test(NAME MPIstubFortran COMMAND main_fortran)

  dll_test_path(MPI::MPI_Fortran "MPIstubFortran")
endif()
