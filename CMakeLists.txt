cmake_minimum_required(VERSION 3.10) 
project(CreateCppProject)

set(CMAKE_CXX_STANDARD 14)
set(SOURCE_FILES main.cpp)
set(CMAKE_LINK_LIBS)

include(".scripts/install_xrepo.cmake")
add_packages("boost" "all=true")
add_packages("nlohmann_json" "")

add_executable(CreateCppProject ${SOURCE_FILES})
get_property(CMAKE_LINK_LIBS GLOBAL PROPERTY CMAKE_LINK_LIBS)
print_links(CMAKE_LINK_LIBS)
target_link_libraries(CreateCppProject PUBLIC ${CMAKE_LINK_LIBS})


