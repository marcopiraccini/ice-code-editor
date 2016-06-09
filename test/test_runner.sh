#!/bin/bash

# Static type analysis
results=$(dartanalyzer lib/ice.dart 2>&1)
results_ignoring_ok_deprecations=$(
  echo "$results" | \
    grep -v "'query' is deprecated" | \
    grep -v "'queryAll' is deprecated" | \
    grep -v "hints found.$"
)
echo "$results_ignoring_ok_deprecations"
count=$(echo "$results_ignoring_ok_deprecations" | wc -l | tr -d " ")
if [[ "$count" != "1" ]]
then
  exit 1
fi
echo "Looks good!"
echo

which content_shell >/dev/null
if [[ $? -ne 0 ]]; then
  $DART_SDK/../chromium/download_contentshell.sh
  unzip content_shell-linux-x64-release.zip

  cs_path=$(ls -d drt-*)
  PATH=$cs_path:$PATH
fi

firefox --version
pwd
ls -l test/ice_test.dart
# ldd `which content_shell`
pub run test -p firefox test/ice_test.dart
