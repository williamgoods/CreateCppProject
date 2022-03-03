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
    green_print("CmakeCache.txt not exit")
    get_property(${variable} GLOBAL PROPERTY ${cache_variable})
  endif()
endmacro(read_cache_variable)
