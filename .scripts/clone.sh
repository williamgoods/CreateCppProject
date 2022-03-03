#!/bin/bash

clone_url=$1
clone_dir=$2

if [ "$(ls -A $clone_dir)" ];then
  cd $clone_dir
  git pull
  cd - >> /dev/null
else
  echo "start clone $clone_url to $clone_dir"
  git clone $clone_url $clone_dir
fi
