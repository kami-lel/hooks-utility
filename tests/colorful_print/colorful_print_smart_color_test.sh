#!/bin/bash

# test scrip for:
# hooks_utility_colorful_print()

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

tmp=$(mktemp)

# FIXME use hooks_utility_colorful_print
echo "colorful print smart color test" | hooks_utility_padding_centered '#'

# default to terminal  =========================================================
echo "default to terminal" | hooks_utility_padding_centered '='

echo "Some Red Content" | hooks_utility_colorful_print "${ANSI_COLOR_RED}"
printf '\n'

echo "Some Green Content" | hooks_utility_colorful_print "${ANSI_COLOR_GREEN}"
printf '\n'

# default to file  =============================================================
echo "default to file" | hooks_utility_padding_centered '='

echo "Some Yellow Content" |
    hooks_utility_colorful_print "${ANSI_COLOR_YELLOW}" 1>"${tmp}"
cat "${tmp}"
printf '\n'

echo "Some Blue Content" | hooks_utility_colorful_print "${ANSI_COLOR_BLUE}" 1>"${tmp}"
cat "${tmp}"
printf '\n'

# use -c  ======================================================================
echo "use -c" | hooks_utility_padding_centered '='

echo "Some Purple Content to Terminal" |
    hooks_utility_colorful_print -c "${ANSI_COLOR_PURPLE}"
printf '\n'

echo "Some Cyan Content to File" |
    hooks_utility_colorful_print -c "${ANSI_COLOR_CYAN}" 2>"${tmp}"
cat "${tmp}"
printf '\n'

# use -C  ======================================================================
echo "use -C" | hooks_utility_padding_centered '='

echo "Some Red Content to Terminal" |
    hooks_utility_colorful_print -C "${ANSI_COLOR_RED}"
printf '\n'

echo "Some Green Content to File" |
    hooks_utility_colorful_print -C "${ANSI_COLOR_GREEN}" 2>"${tmp}"
cat "${tmp}"
printf '\n'
