



















file(GLOB SOURCE_FILES 
    CONFIGURE_DEPENDS
    "*/*.h"
    "*/*.cpp")
add_executable(${CMAKE_PROJECT_NAME} ${SOURCE_FILES})
read_cache_variable(CMAKE_LINK_LIBS CMAKE_LINK_LIBS)
print_links(CMAKE_LINK_LIBS)
target_link_libraries(${CMAKE_PROJECT_NAME} PUBLIC ${CMAKE_LINK_LIBS})
