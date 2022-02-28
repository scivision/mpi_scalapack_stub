cmake_minimum_required(VERSION 3.19...3.23)

project(NoMPIDemo LANGUAGES C CXX Fortran)

enable_testing()

include(CheckSourceCompiles)

find_package(mpi_scalapack_stub CONFIG REQUIRED)

add_compile_options($<$<COMPILE_LANGUAGE:C,CXX>:-Werror>)

add_executable(main_c main.c)
target_link_libraries(main_c PRIVATE MPI::MPI_C)
add_test(NAME MPIstubC COMMAND main_c)

add_executable(main_cpp main.cpp)
target_link_libraries(main_cpp PRIVATE MPI::MPI_CXX)
add_test(NAME MPIstubC++ COMMAND main_cpp)

check_source_compiles(Fortran
"program a
implicit none (type, external)
external :: mpi_finalize
end program"
HAS_MPI_FINALIZE
)
if(NOT HAS_MPI_FINALIZE)
  message(FATAL_ERROR "Build MPI_scalapack_stub with option -DMPI1=on")
endif()

add_executable(main_fortran main.f90)
target_link_libraries(main_fortran PRIVATE MPI::MPI_Fortran)
add_test(NAME MPIstubFortran COMMAND main_fortran)

if(WIN32 AND CMAKE_VERSION VERSION_GREATER_EQUAL 3.22)
  # in case MPI is shared lib, need DLL on PATH
  get_target_property(imtype MPI::MPI_C TYPE)
  if(imtype STREQUAL SHARED_LIBRARY)
    get_target_property(imconf MPI::MPI_C IMPORTED_CONFIGURATIONS)
    list(GET imconf 0 imconf)
    get_target_property(imloc MPI::MPI_C IMPORTED_LOCATION_${imconf})
    cmake_path(GET imloc PARENT_PATH imloc)

    set_tests_properties(MPIstubC MPIstubC++ MPIstubFortran PROPERTIES
    ENVIRONMENT_MODIFICATION PATH=path_list_append:${imloc}
    )
  endif()
endif()
