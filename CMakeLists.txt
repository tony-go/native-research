cmake_minimum_required(VERSION 3.26)

project(EatSwiftFromCPP LANGUAGES CXX Swift)

# Check Swift compiler version

if("${CMAKE_Swift_COMPILER_VERSION}" VERSION_LESS 5.9)
  message(FATAL_ERROR "Bidirectional C++ Interop requires Swift 5.9 or greater. Have ${CMAKE_Swift_COMPILER_VERSION}")
endif()

# Check that Clang is the C++ compiler as this interopability is only available with Clang

if(NOT "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" AND
   NOT "${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
  message(FATAL_ERROR "Project requires building with Clang.
  Have ${CMAKE_CXX_COMPILER_ID}")
endif()

# We basically include .cmake files which contains our cmake functions.

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(AddSwift)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_OSX_DEPLOYMENT_TARGET 13.0)

add_subdirectory(app)

add_executable(my_app main.cc)

target_link_libraries(my_app PRIVATE swift_lib)
target_include_directories(my_app PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/app/include")

set_target_properties(my_app PROPERTIES MACOSX_BUNDLE TRUE)
