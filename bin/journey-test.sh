#!/usr/bin/env bash

assert_installed() {
  local ok=0
  for executable in $@; do
    if [[ "`which $executable`" == "" ]]; then
      echo "Missing executable: $executable"
      ok=1
    fi
  done
  if [[ "$ok" != "0" ]]; then exit $ok; fi
}

main() {
  cd "${EXECPATH}"

  local xerlang=$(pwd)
  local build_dir="build"
  local build_path="${xerlang}/${build_dir}"

  local xapi_home="${build_path}/x-api"
  local trackler_home="${build_path}/trackler"
  local exercism_home="${build_path}/exercism"

  local exercism_config_file=".journey-test.exercism.json"
  local xapi_port=9292

  # fail fast if required tools are missing
  assert_installed "erl" "rebar3"
}

# Show expanded commands
set -x

# Determine path of this script as well as the current execution dir
SCRIPTPATH=$(pushd `dirname $0` > /dev/null && pwd && popd > /dev/null)
EXECPATH=$(pwd)

# Make output easier to read in CI
TERM=dumb


xapi_pid=""
# trap on_exit EXIT
main
