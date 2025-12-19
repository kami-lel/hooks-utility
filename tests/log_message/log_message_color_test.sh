#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

tmp=$(mktemp)

echo "log style message test on -c/-C" | hooks_utility_padding_centered '#'

# default to terminal  =========================================================
echo "default to terminal" | hooks_utility_padding_centered '='
echo "Some Error Message Content" | hooks_utility_error

# default to file  =============================================================
echo "default to file" | hooks_utility_padding_centered '='

echo "Some Error Message Content" | hooks_utility_error 1>"${tmp}"
cat "${tmp}"

echo "Some Info Message Content" | hooks_utility_info 1>"${tmp}"
cat "${tmp}"

# use -c  ======================================================================
echo "use -c" | hooks_utility_padding_centered '='

echo "Some Error Message Content to Terminal" | hooks_utility_error -c

echo "Some Error Message Content to File" | hooks_utility_error -c 1>"${tmp}"
cat "${tmp}"

# use -C  ======================================================================
echo "use -C" | hooks_utility_padding_centered '='

echo "Some Error Message Content to Terminal" | hooks_utility_error -C

echo "Some Error Message Content to File" | hooks_utility_error -C 1>"${tmp}"
cat "${tmp}"
