#!/usr/bin/env bash

# formats directory with clang-format
# this is a very dirty way of achieving this,
# more like a hack
[[ $# -ne 1 ]] && echo "Usage: directory to format" && exit 1;

find $1 -iname *.[hct]pp | xargs clang-format -i -style=file
