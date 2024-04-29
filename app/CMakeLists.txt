find_library(COCOA_LIBRARY Cocoa)

# This function is written in the "cmake/AddSwift.cmake" file
# It will generate the header file to consume Swift code from C++.

generate_cxx_header_target_from_swift(
  swift_lib_h
  Native
  "${CMAKE_CURRENT_BINARY_DIR}/include/swift-lib.h"
  SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/App.swift"
  SEARCH_PATHS "${CMAKE_CURRENT_SOURCE_DIR}/include")

# Now we need to create a Library for Swift sources

add_library(swift_lib STATIC App.swift App.cc)

# The library requires the Swift header in order to compile, so we create a
#   dependency between the library and the header target created above.

add_dependencies(swift_lib swift_lib_h)
target_link_libraries(swift_lib PUBLIC ${COCOA_LIBRARY})
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/include")

# This libraries, and users of this library, will need to find the
#   generated header.

target_include_directories(swift_lib PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/include")

# Manually override the Swift module name to "SwiftLib" to match the
#   name in the generated header header above.

set_target_properties(swift_lib PROPERTIES Swift_MODULE_NAME "Native")

# Enable C++ interoperability mode on all Swift compilations. Again, this is
#   We make it 'PUBLIC' to ensure the flag is propagated to users of the library.

target_compile_options(swift_lib PUBLIC
  "$<$<COMPILE_LANGUAGE:Swift>:-cxx-interoperability-mode=default>")

