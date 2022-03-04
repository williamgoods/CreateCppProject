
execute_process(
  COMMAND python "${CMAKE_SOURCE_DIR}/.scripts/count_add_packages.py" ${CMAKE_SOURCE_DIR}
  ERROR_VARIABLE count
)

message("count is ${count}")
string(REPLACE "\n" "" count ${count})
set_cache_variable(count CMAKE_PACKAGES_COUNT)
