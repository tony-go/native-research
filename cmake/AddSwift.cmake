include(CheckCompilerFlag)

function(generate_cxx_header_target_from_swift target module header)
  cmake_parse_arguments(ARG "" "" "SOURCES;SEARCH_PATHS" ${ARGN})
  if(NOT ARG_SOURCES)
    message(FATAL_ERROR "No sources provided to 'swift_generate_cxx_header_target'")
  endif()

  if(APPLE)
    set(SDK_FLAGS "-sdk" "${CMAKE_OSX_SYSROOT}")
  elseif(WIN32)
    set(SDK_FLAGS "-sdk" "$ENV{SDKROOT}")
  endif()

  if(ARG_SEARCH_PATHS)
    list(TRANSFORM ARG_SEARCH_PATHS PREPEND "-I")
  endif()

  add_custom_command(
    OUTPUT
      "${header}"
    COMMAND
      ${CMAKE_Swift_COMPILER} -frontend -typecheck
      ${ARG_SEARCH_PATHS}
      ${ARG_SOURCES}
      ${SDK_FLAGS}
      -module-name "${module}"
      -cxx-interoperability-mode=default
      -emit-clang-header-path "${header}"
    COMMENT
      "Generating '${header}'"
  )

  add_custom_target("${target}"
    DEPENDS
      "${header}"
  )
endfunction()
