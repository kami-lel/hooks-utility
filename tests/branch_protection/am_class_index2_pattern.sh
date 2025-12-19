#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

# tests for
# _am_class_index2pattern()

echo '_am_class_index2pattern() test' | hooks_utility_padding_centered '#'

echo 'primary' | hooks_utility_padding_centered '-'
printf '%s\n' "$(_am_class_index2pattern 1)"

echo 'secondary' | hooks_utility_padding_centered '-'
printf '%s\n' "$(_am_class_index2pattern 2)"

echo 'tertiary' | hooks_utility_padding_centered '-'
printf '%s\n' "$(_am_class_index2pattern 3)"
