macro(green_print message)
  execute_process(COMMAND
    ${CMAKE_COMMAND} -E cmake_echo_color --green --bold ${message}
  )
endmacro(green_print)

macro(print_links links)
  LIST(LENGTH ${links} LINKS)

  if (LINKS)
    set(links_message "\ncmake linking libs:\n\t${${links}}\n")
    string(REPLACE ";" "\\n\\t" links_message_out "${links_message}")
    green_print(${links_message_out})
  endif()
endmacro(print_links)

macro(read_cache_variable cache_variable variable)
  if (EXISTS "${CMAKE_SOURCE_DIR}/build/CMakeCache.txt")
    set(${variable} "$CACHE{${cache_variable}}")
  else()
    get_property(${variable} GLOBAL PROPERTY ${cache_variable})
  endif()
endmacro(read_cache_variable)

macro(set_cache_variable cache_variable variable)
  if (EXISTS "${CMAKE_SOURCE_DIR}/build/CMakeCache.txt")
    set(${variable} "${${cache_variable}}" CACHE STRING "CMAKE_LINK_LIBS" FORCE)
  else()
    set_property(GLOBAL PROPERTY ${variable} "${${cache_variable}}")
  endif()
endmacro(set_cache_variable)

macro(include_link package_name)
  if (NOT ${${package_name}_INCLUDE_DIR} STREQUAL "")
    include_directories(${${package_name}_INCLUDE_DIR})
  endif()

  read_cache_variable(CMAKE_LINK_LIBS tmp)
  if (NOT ${${package_name}_LINK_DIR} STREQUAL "")
    link_directories(${${package_name}_LINK_DIR})

    # list(APPEND tmp "${${package_name}_CMAKE_LINK_LIBS}")
    string(CONCAT tmp "${tmp};" "${${package_name}_CMAKE_LINK_LIBS}")
    # message("${package_name} ----- has ${${package_name}_CMAKE_LINK_LIBS}")
    # string(REPLACE "lib" "" tmp "${tmp}")
    # SET(CMAKE_LINK_LIBS "${tmp}" CACHE STRING "CMAKE_LINK_LIBS" FORCE)
  endif()
  set_property(GLOBAL PROPERTY CMAKE_LINK_LIBS "${tmp}")
  set(CMAKE_LINK_LIBS "${tmp}" CACHE STRING "CMAKE_LINK_LIBS" FORCE)

  if(DEFINED cmake_pack_id)
    math(EXPR cmake_pack_id "${cmake_pack_id}+1")
  else()
    # math(EXPR cmake_pack_count "1" DECIMAL)
    set(cmake_pack_id 1)
  endif()
  read_cache_variable(CMAKE_PACKAGES_COUNT cmake_pack_count)

  if (cmake_pack_id EQUAL cmake_pack_count)
    green_print("should include end section")
    include("${CMAKE_SOURCE_DIR}/.scripts/end_project.cmake")
    #  add_executable(${CMAKE_PROJECT_NAME} ${SOURCE_FILES})
    #  read_cache_variable(CMAKE_LINK_LIBS CMAKE_LINK_LIBS)
    #  print_links(CMAKE_LINK_LIBS)
    #  target_link_libraries(${CMAKE_PROJECT_NAME} PUBLIC ${CMAKE_LINK_LIBS})
  endif()
endmacro(include_link)

macro(add_packages package_name features)
  set(add_message "\nadd package ${package_name}:")
  execute_process(COMMAND
    ${CMAKE_COMMAND} -E cmake_echo_color --green --bold ${add_message}
  )
  xrepo_package(
    "${package_name}"
    CONFIGS ${features}
  )
  include_link(${package_name})
endmacro(add_packages)
