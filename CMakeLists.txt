cmake_minimum_required(VERSION 3.12)

set(PROJECT_NAME UnoFreeRTOS)

project(${PROJECT_NAME} LANGUAGES C)

# Let CMake paths to easily find our custom CMake modules
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(cmake/compiler-config.cmake)
include(cmake/macros.cmake)

default_build_type("Release")
common_output_dirs()

set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Headers live in include
include_directories(include)

# The source lives in src
add_subdirectory(src)

message(STATUS "\n\n========= Build Options ===========")
message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")
message(STATUS "\n\n-----------------------------------")
