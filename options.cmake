option(MPI1 "Build MPI-1 stub")
option(fortran "Build MPI::MPI_Fortran" ON)

# Necessary for shared library with Visual Studio / Windows oneAPI
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS true)

# --- default install directory under build/local
if(PROJECT_IS_TOP_LEVEL AND CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  # will not take effect without FORCE
  set(CMAKE_INSTALL_PREFIX ${PROJECT_BINARY_DIR}/local CACHE PATH "Install top-level directory" FORCE)
endif()
