cmake_minimum_required(VERSION 3.15...3.24)

project(mpi_scalapack_stub
LANGUAGES C CXX
VERSION 1.0.1
)

# test by linking to example/ project

option(MPI1 "Build MPI-1 stub")
option(fortran "Build MPI::MPI_Fortran" ON)

if(fortran)
  enable_language(Fortran)
endif()

include(cmake/options.cmake)

add_subdirectory(src)

# --- main libraries
add_library(mpi_c src/mpic.c)
target_include_directories(mpi_c PUBLIC
$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
$<INSTALL_INTERFACE:include>
)
set_target_properties(mpi_c PROPERTIES
EXPORT_NAME MPI_C
)

add_library(mpi_cxx src/mpic.c)
target_include_directories(mpi_cxx PUBLIC
$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
$<INSTALL_INTERFACE:include>
)
set_target_properties(mpi_cxx PROPERTIES
EXPORT_NAME MPI_CXX
)

if(fortran)
  add_library(mpi_fortran src/mpi.f90 $<TARGET_OBJECTS:elapse>)
  target_include_directories(mpi_fortran PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
  $<INSTALL_INTERFACE:include>
  )
  if(MPI1)
    target_sources(mpi_fortran PRIVATE src/mpi_legacy.f90)
    # use MUMPS::MPISEQ to avoid symbol clashes
  endif()
  set_target_properties(mpi_fortran PROPERTIES
  EXPORT_NAME MPI_Fortran
  Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include
  )

  install(TARGETS mpi_fortran
  EXPORT ${PROJECT_NAME}-targets
  )
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/include/mpi.mod
  TYPE INCLUDE
  )

endif()

install(TARGETS mpi_c mpi_cxx
EXPORT ${PROJECT_NAME}-targets
)
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/src/mpi.h
TYPE INCLUDE
)

include(cmake/install.cmake)

# FetchContent targets
add_library(MPI::MPI_C INTERFACE IMPORTED GLOBAL)
target_link_libraries(MPI::MPI_C INTERFACE mpi_c)

add_library(MPI::MPI_CXX INTERFACE IMPORTED GLOBAL)
target_link_libraries(MPI::MPI_CXX INTERFACE mpi_cxx)

if(fortran)
  add_library(MPI::MPI_Fortran INTERFACE IMPORTED GLOBAL)
  target_link_libraries(MPI::MPI_Fortran INTERFACE mpi_fortran)
endif()
