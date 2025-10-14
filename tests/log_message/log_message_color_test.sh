#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../scripts/hooks/hooks_utility.sh"

tmp=$(mktemp)


echo \
"tests: log style message, -c/-C  #############################################\
##"

echo \
"default behavior to terminal  ------------------------------------------------\
--"

echo "Some Error Message Content" | hooks_utility_error

echo \
"default behavior to file  ----------------------------------------------------\
--"

echo "Some Error Message Content" | hooks_utility_error 2> "${tmp}"
cat "${tmp}"

echo \
"use -c  ----------------------------------------------------------------------\
--"

echo "Some Error Message Content" | hooks_utility_error -c
echo "Some Error Message Content" | hooks_utility_error -c 2> "${tmp}"
cat "${tmp}"

echo \
"use -C  ----------------------------------------------------------------------\
--"

echo "Some Error Message Content" | hooks_utility_error -C
echo "Some Error Message Content" | hooks_utility_error -C 2> "${tmp}"
cat "${tmp}"