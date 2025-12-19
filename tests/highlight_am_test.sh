#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../hooks_utility.sh"

# tests for:
# _highlight_am_in_git_diff_line()

line=""
am_class_index=1
pattern="$(_am_index2pattern "${am_class_index}")"
_highlight_am_in_git_diff_line "${line}" "${am_class_index}" "${pattern}"

"${PRIMARY_AM_PATTERN}"
