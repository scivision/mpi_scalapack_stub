add_library(elapse OBJECT elapse.c)
target_include_directories(elapse INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

if(fortran)
  add_library(scalapack scalapack.f90 blacs.f90)
endif()
