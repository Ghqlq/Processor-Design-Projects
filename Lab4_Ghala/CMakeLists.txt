cmake_minimum_required(VERSION 3.24)
include(cmake/BootstrapVcpkg.cmake)
project(week-four-lab VERSION 1.0.0)

find_package(nyu-cmake CONFIG REQUIRED)
add_library(lab4 INTERFACE)
add_subdirectory(rtl)

if(NYU_BUILD_TESTS)
  enable_testing()
  add_subdirectory(dv)
endif()
