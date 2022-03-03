#!/bin/bash

mkdir -p build

cd build
#cmake -G Ninja -DCMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake ..
# cmake -P ../.script/prebuild.cmake
cmake -G Ninja .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1
#ninja clean
ninja -j 32

# variable='CMAKE_PROJECT_NAME'
# ProjectName=""
# CMakePorjectNameStatic="CMAKE_PROJECT_NAME:STATIC="
# 
# cat CMakeCache.txt | while read line
# do
#     if [[ "$line" =~ .*"$variable".* ]]; then
#         length=${#line}
#         CMAKE_PROJECT_NAME_LENGTH=${#CMakePorjectNameStatic}
#         ProjectName=${line:$CMAKE_PROJECT_NAME_LENGTH:$length}
#         bash -c "./${ProjectName}"
#         break
#     fi 
# done
# 
# cd ..


