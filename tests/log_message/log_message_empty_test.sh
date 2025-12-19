#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

echo 'log style message, empty test' | hooks_utility_padding_left_just '#'

echo 'empty debug' | hooks_utility_padding_centered '-'
echo '' | hooks_utility_debug

echo 'empty info' | hooks_utility_padding_centered '-'
echo '' | hooks_utility_info

echo 'empty warning' | hooks_utility_padding_centered '-'
echo '' | hooks_utility_warning

echo 'empty error' | hooks_utility_padding_centered '-'
echo '' | hooks_utility_error

echo 'empty critical' | hooks_utility_padding_centered '-'
echo '' | hooks_utility_critical
