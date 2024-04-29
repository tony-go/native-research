find_library(COCOA_LIBRARY Cocoa)

# This function is written in the "cmake/AddSwift.cmake" file
# It will generate the header file to consume Swift code from C++.

generate_cxx_header_target_from_swift(
  window_h
  Ui
  "${CMAKE_CURRENT_BINARY_DIR}/include/window-swift.h"
  SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/window.swift"
  SEARCH_PATHS "${CMAKE_CURRENT_SOURCE_DIR}/include")

# Now we need to create a Library for Swift sources

add_library(window STATIC window.swift window.cc)

# The library requires the Swift header in order to compile, so we create a
#   dependency between the library and the header target created above.

add_dependencies(window window_h)
target_link_libraries(window PUBLIC ${COCOA_LIBRARY})
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/include")

# This libraries, and users of this library, will need to find the
#   generated header.

target_include_directories(window PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/include")

# Manually override the Swift module name to "SwiftLib" to match the
#   name in the generated header header above.

set_target_properties(window PROPERTIES Swift_MODULE_NAME "Ui")

# Enable C++ interoperability mode on all Swift compilations. Again, this is
#   We make it 'PUBLIC' to ensure the flag is propagated to users of the library.

target_compile_options(window PUBLIC
  "$<$<COMPILE_LANGUAGE:Swift>:-cxx-interoperability-mode=default>")

