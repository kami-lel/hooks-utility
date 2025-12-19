#!/bin/bash

# test scrip for:
# hooks_utility_colorful_print()

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

# FIXME use hooks_utility_colorful_print
echo "colorful print smart color test" | hooks_utility_padding_centered '#'
echo "Some Red Content" | _colorful_print "${ANSI_COLOR_RED}" 1
printf '\n'
echo "Some Green Content" | _colorful_print "${ANSI_COLOR_GREEN}" 1
printf '\n'

echo "default to terminal" | hooks_utility_padding_centered '='

echo "default to file" | hooks_utility_padding_centered '='
echo "use -c" | hooks_utility_padding_centered '='
echo "use -C" | hooks_utility_padding_centered '='
