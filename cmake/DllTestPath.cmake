function(dll_test_path lib test_names)
# if shared lib on Windows, need DLL on PATH

if(NOT WIN32)
  return()
endif()

if(CMAKE_VERSION VERSION_LESS 3.22)
  message(VERBOSE "CMake ${CMAKE_VERSION} < 3.22: cannot apply ENVIRONMENT_MODIFICATION to ${test_names}")
  return()
endif()


get_target_property(imtype ${lib} TYPE)
if(NOT imtype STREQUAL "SHARED_LIBRARY")
  message(DEBUG "${lib} is not a shared library, no need for ENVIRONMENT_MODIFICATION for ${test_names}")
  return()
endif()

get_target_property(imconf ${lib} IMPORTED_CONFIGURATIONS)
list(GET imconf 0 imconf)
# assume first configuration is desired
if(NOT imconf)
  message(VERBOSE "did not find imported config for ${lib}")
  return()
endif()

get_target_property(imloc ${lib} IMPORTED_LOCATION_${imconf})
if(NOT imconf)
  message(VERBOSE "did not find imported location for ${lib}")
  return()
endif()

cmake_path(GET imloc PARENT_PATH imloc)

set_tests_properties(${test_names} PROPERTIES
ENVIRONMENT_MODIFICATION PATH=path_list_append:${imloc}
)

endfunction(dll_test_path)
