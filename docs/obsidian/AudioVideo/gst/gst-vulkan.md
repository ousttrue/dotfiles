https://gist.github.com/jwinarske/dda0f7154a0bf34c3e7b6606907ad0f7

```cmake
# project
cmake_minimum_required(VERSION 3.20.0)
project(appsink VERSION 0.1.0)
set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
if(NOT PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  # Git auto-ignore out-of-source build directory
  file(
    GENERATE
    OUTPUT .gitignore
    CONTENT "*")
endif()

set(CMAKE_CXX_STANDARD 20)

find_package(PkgConfig REQUIRED)
pkg_search_module(gstreamer REQUIRED IMPORTED_TARGET gstreamer-1.0)
pkg_search_module(gstreamer-vulkan REQUIRED IMPORTED_TARGET
                  gstreamer-vulkan-1.0)

find_package(Vulkan REQUIRED)

# target
add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(
  ${PROJECT_NAME} PRIVATE PkgConfig::gstreamer PkgConfig::gstreamer-vulkan
                          Vulkan::Vulkan)
```
