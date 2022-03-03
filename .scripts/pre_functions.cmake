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
