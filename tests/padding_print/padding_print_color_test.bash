#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

tmp=$(mktemp)
title='Title Name'

# ENABLE_ANSI_COLOR=1  =========================================================
enable_ansi_color_default="${ENABLE_ANSI_COLOR}"
export ENABLE_ANSI_COLOR=1
echo "ENABLE_ANSI_COLOR=1"

echo "default behavior to terminal:"
echo "${title}" | hooks_utility_padding_left_just '#'

echo "default behavior to file:"
echo "${title}" | hooks_utility_padding_right_just '#' 1>"${tmp}"
cat "${tmp}"

echo "use -c to terminal:"
echo "${title}" | hooks_utility_padding_centered -c '#'

echo "use -c to file:"
echo "${title}" | hooks_utility_padding_centered -c '#' 1>"${tmp}"
cat "${tmp}"

echo "use -C to terminal:"
echo "${title}" | hooks_utility_padding_centered -C '#'

echo "use -C to file:"
echo "${title}" | hooks_utility_padding_centered -C '#' 1>"${tmp}"
cat "${tmp}"

# ENABLE_ANSI_COLOR=0  =========================================================
echo "ENABLE_ANSI_COLOR=0"
export ENABLE_ANSI_COLOR=0

echo "default behavior to terminal:"
echo "${title}" | hooks_utility_padding_left_just '#'

echo "default behavior to file:"
echo "${title}" | hooks_utility_padding_right_just '#' 1>"${tmp}"
cat "${tmp}"

echo "use -c to terminal:"
echo "${title}" | hooks_utility_padding_centered -c '#'

echo "use -c to file:"
echo "${title}" | hooks_utility_padding_centered -c '#' 1>"${tmp}"
cat "${tmp}"

echo "use -C to terminal:"
echo "${title}" | hooks_utility_padding_centered -C '#'

echo "use -C to file:"
echo "${title}" | hooks_utility_padding_centered -C '#' 1>"${tmp}"
cat "${tmp}"

export ENABLE_ANSI_COLOR="${enable_ansi_color_default}"
