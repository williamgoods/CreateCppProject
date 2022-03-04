cmake_minimum_required(VERSION 3.10) 
project(CreateCppProject)
set(CMAKE_CXX_STANDARD 14)

# set(SOURCE_FILES main.cpp)

include(".scripts/install_xrepo.cmake")
add_packages("boost" "all=true")
add_packages("nlohmann_json" "")

# add_executable(CreateCppProject ${SOURCE_FILES})
# 
# read_cache_variable(CMAKE_LINK_LIBS CMAKE_LINK_LIBS)
# print_links(CMAKE_LINK_LIBS)
# target_link_libraries(CreateCppProject PUBLIC ${CMAKE_LINK_LIBS})
