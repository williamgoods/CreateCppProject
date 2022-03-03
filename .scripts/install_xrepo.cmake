include(ExternalProject)
include("${CMAKE_SOURCE_DIR}/.scripts/pre_functions.cmake")

SET(CMAKE_LINK_LIBS "${CMAKE_LINK_LIBS}" CACHE INTERNAL "CMAKE_LINK_LIBS")

SET(ROOT_DIR ${CMAKE_SOURCE_DIR})
SET(ROOT_XREPO "${CMAKE_SOURCE_DIR}/.xrepo")

execute_process(
  COMMAND bash "${ROOT_DIR}/.scripts/install_xrepo.sh" ${ROOT_DIR}
)

include("${ROOT_DIR}/.xrepo/xrepo.cmake")

macro(include_link package_name)
  include_directories(${${package_name}_INCLUDE_DIR})
  link_directories(${${package_name}_LINK_DIR})

  get_property(tmp GLOBAL PROPERTY CMAKE_LINK_LIBS)

  list(APPEND tmp "${${package_name}_CMAKE_LINK_LIBS}")
  # message("${package_name} ----- has ${${package_name}_CMAKE_LINK_LIBS}")

  set_property(GLOBAL PROPERTY CMAKE_LINK_LIBS "${tmp}")
endmacro(include_link)

function(add_packages package_name features)
  set(add_message "\nadd package ${package_name}:")
  execute_process(COMMAND 
    ${CMAKE_COMMAND} -E cmake_echo_color --green --bold ${add_message}
  )
  xrepo_package(
    "${package_name}"
    CONFIGS ${features}
  )
  include_link(${package_name}) 
endfunction(add_packages)