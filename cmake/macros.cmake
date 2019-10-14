macro(build_optional var subdir)
  message(STATUS "${var}: ${${var}}")
  if(${${var}})
    add_subdirectory(${subdir})
  endif()
endmacro()

macro(common_output_dirs)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/bin)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/lib)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/lib)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/bin)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/lib)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/lib)
endmacro()

# https://blog.kitware.com/cmake-and-the-default-build-type/
macro(default_build_type)
  # Set a default build type if none was specified
  if("${ARGV0}" STREQUAL "")
    set(build_type "Release")
    if(EXISTS "${CMAKE_SOURCE_DIR}/.git")
      set(build_type "Debug")
    endif()
  else()
    set(build_type "${ARGV0}")
  endif()

  if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(
      STATUS "Setting build type to '${build_type}' as none was specified.")
    set(CMAKE_BUILD_TYPE
        "${build_type}"
        CACHE STRING "Choose the type of build." FORCE)
    # Set the possible values of build type for cmake-gui
    set_property(CACHE CMAKE_BUILD_TYPE
                 PROPERTY STRINGS
                          "Debug"
                          "Release"
                          "MinSizeRel"
                          "RelWithDebInfo")
  endif()
endmacro()

# Enable testing for the project and define helper macros
if(NOT ${CMAKE_CROSSCOMPILING})
  enable_testing()
endif()

add_custom_target(check COMMAND ${CMAKE_CTEST_COMMAND} --OUTPUT-ON-FAILURE)

macro(project_set_test ...)
  set(_testName ${ARGV0})
  set_target_properties(${_testName}
                        PROPERTIES RUNTIME_OUTPUT_DIRECTORY
                                   "${CMAKE_CURRENT_BINARY_DIR}/test"
                                   LIBRARY_OUTPUT_DIRECTORY
                                   "${CMAKE_CURRENT_BINARY_DIR}/test"
                                   ARCHIVE_OUTPUT_DIRECTORY
                                   "${CMAKE_CURRENT_BINARY_DIR}/test"
                                   RUNTIME_OUTPUT_DIRECTORY_DEBUG
                                   "${CMAKE_CURRENT_BINARY_DIR}/test"
                                   LIBRARY_OUTPUT_DIRECTORY_DEBUG
                                   "${CMAKE_CURRENT_BINARY_DIR}/test"
                                   ARCHIVE_OUTPUT_DIRECTORY_DEBUG
                                   "${CMAKE_CURRENT_BINARY_DIR}/test"
                                   RUNTIME_OUTPUT_DIRECTORY_RELEASE
                                   "${CMAKE_CURRENT_BINARY_DIR}/test"
                                   LIBRARY_OUTPUT_DIRECTORY_RELEASE
                                   "${CMAKE_CURRENT_BINARY_DIR}/test"
                                   ARCHIVE_OUTPUT_DIRECTORY_RELEASE
                                   "${CMAKE_CURRENT_BINARY_DIR}/test")

  # Integrate the test with ctest for running easily later.
  add_test(${_testName}
           ${CMAKE_CTEST_COMMAND}
           --build-and-test
           "${CMAKE_SOURCE_DIR}"
           "${CMAKE_BINARY_DIR}"
           --build-target
           ${_testName}
           --build-generator
           ${CMAKE_GENERATOR}
           --build-makeprogram
           ${CMAKE_MAKE_PROGRAM}
           --build-nocmake
           --build-noclean
           --build-exe-dir
           "${CMAKE_CURRENT_BINARY_DIR}/test"
           --output-on-failure
           --test-command
           ${ARGV})
endmacro()

macro(project_add_test ...)
  add_executable(${ARGV})

  project_set_test(${ARGV})

  if(${CODE_COVERAGE})
    add_dependencies(coverage ${_testName})
  endif()
endmacro()
