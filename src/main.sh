#!/usr/bin/env bash

shopt -s -o errexit

# https://stackoverflow.com/a/77663806/11045433
SOURCE_DIRNAME=$(dirname "$( readlink -f "${BASH_SOURCE[0]:-"$( command -v -- "$0" )"}" )")

source "$SOURCE_DIRNAME/delimited-arrays.sh"

function corepack_available() {
  which corepack &> /dev/null
}

function ensure_corepack() {
  if corepack_available; then return; fi
  npm install -g corepack@latest
}

function main() {
  ensure_corepack
  local raw_package_managers="${1:?missing argument for package managers parameter}"
  local package_managers
  ReadSep ";" package_managers < <(echo -n "$raw_package_managers")
  corepack enable "${package_managers[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
