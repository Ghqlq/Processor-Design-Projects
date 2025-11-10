cmake_minimum_required(VERSION 4.1)
project(Lab1_Ghala VERSION 1.0.0)
add_executable(hello_world)
target_sources(hello_world PRIVATE src/hello.cpp src/name.cpp)
target_include_directories(hello_world PRIVATE include)

