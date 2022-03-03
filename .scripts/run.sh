#!/bin/bash

cd build

variable='CMAKE_PROJECT_NAME'
ProjectName=""
CMakePorjectNameStatic="CMAKE_PROJECT_NAME:STATIC="

cat CMakeCache.txt | while read line
do
    if [[ "$line" =~ .*"$variable".* ]]; then
        length=${#line}
        CMAKE_PROJECT_NAME_LENGTH=${#CMakePorjectNameStatic}
        ProjectName=${line:$CMAKE_PROJECT_NAME_LENGTH:$length}
        bash -c "./${ProjectName}"
        break
    fi
done

cd ..
