#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

echo 'log style message, empty test' | hooks_utility_padding_left_just '#'
# only prefix  =================================================================
echo 'only prefix' | hooks_utility_padding_centered '='

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

# with date-time  ==============================================================
echo 'with date-time' | hooks_utility_padding_centered '='

echo 'with date' | hooks_utility_padding_centered '-'
echo '' | hooks_utility_info -d

echo 'with time' | hooks_utility_padding_centered '-'
echo '' | hooks_utility_warning -t

echo 'with date time' | hooks_utility_padding_centered '-'
echo '' | hooks_utility_error -dt
