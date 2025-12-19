#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../hooks_utility.sh"

# tests for:
# _highlight_am_in_git_diff_line()

_highlight_am_in_git_diff_line "" "${PRIMARY_AM_PATTERN}"
