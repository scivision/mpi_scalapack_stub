[![ci](https://github.com/scivision/mpi_scalapack_stub/actions/workflows/ci.yml/badge.svg)](https://github.com/scivision/mpi_scalapack_stub/actions/workflows/ci.yml)

# MPI Scalapack stub

No-MPI stub for single-core use of some MPI-2 programs
Based on part of MUMPS package.

Use by CMake FetchContent or as an installed package.

```sh
cmake -B build --install-prefix=$HOME/mylibs
cmake --build build
cmake --install build
```
