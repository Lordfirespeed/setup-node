#!/usr/bin/env bash

function PrintSep {
  local separator=${1:?missing separator argument}
  python3 -c "import sys; print(*sys.argv[1:], sep='${separator}', end='')" "${@:2}"
}
export -f PrintSep

function ReadSep {
  local separator=${1:?missing separator argument}
  local array_name=${2:?missing array name argument}
  readarray -t -d "$separator" "$array_name"
}
export -f ReadSep
