cmake_minimum_required(VERSION 3.10) 
project(CreateCppProject)

set(CMAKE_CXX_STANDARD 14)
set(SOURCE_FILES main.cpp)
set(CMAKE_LINK_LIBS)

include(".scripts/install_xrepo.cmake")
add_packages("boost" "all=true")
add_packages("nlohmann_json" "")

add_executable(CreateCppProject ${SOURCE_FILES})
# if (EXISTS "${CMAKE_SOURCE_DIR}/build/CMakeCache.txt")
#     set(CMAKE_LINK_LIBS "$CACHE{CMAKE_LINK_LIBS}")
# else()
#     green_print("cmakecache.txt not exit")
#     get_property(CMAKE_LINK_LIBS GLOBAL PROPERTY CMAKE_LINK_LIBS)
# endif()
read_cache_variable(CMAKE_LINK_LIBS CMAKE_LINK_LIBS)
print_links(CMAKE_LINK_LIBS)
target_link_libraries(CreateCppProject PUBLIC ${CMAKE_LINK_LIBS})
SET(CMAKE_LINK_LIBS "${CMAKE_LINK_LIBS}" CACHE STRING "CMAKE_LINK_LIBS" FORCE)


