#!/bin/bash

cmake_root_dir=$1
xrepo_url="https://github.com/williamgoods/xrepo-cmake.git"
xrepo_dir=$cmake_root_dir/.xrepo/

# bash $cmake_root_dir/.scripts/clone.sh $xrepo_url $xrepo_dir
python $cmake_root_dir/.scripts/clone.py $xrepo_url $xrepo_dir

