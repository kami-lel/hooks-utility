#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

tmp=$(mktemp)

echo "log style message test on -c/-C" | hooks_utility_padding_centered '#'

echo "default to terminal" | hooks_utility_padding_centered '='
echo "Some Error Message Content" | hooks_utility_error

echo "default to file" | hooks_utility_padding_centered '='
echo "Some Error Message Content" | hooks_utility_error 2>"${tmp}"
cat "${tmp}"

echo "use -c" | hooks_utility_padding_centered '='
echo "Some Error Message Content" | hooks_utility_error -c
echo "Some Error Message Content" | hooks_utility_error -c 2>"${tmp}"
cat "${tmp}"

echo "use -C" | hooks_utility_padding_centered '='
echo "Some Error Message Content" | hooks_utility_error -C
echo "Some Error Message Content" | hooks_utility_error -C 2>"${tmp}"
cat "${tmp}"
