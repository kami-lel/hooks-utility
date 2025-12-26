#!/bin/bash

# test special character of hooks_utility_colorful_print()

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

# TODO

echo "special character tests" | hooks_utility_padding_centered '#'

# as literal  ==================================================================
echo "as literal" | hooks_utility_padding_centered '='
printf '%s' "\n" | hooks_utility_padding_centered '-'
printf '%s' "\t" | hooks_utility_padding_centered '-'

# as interpreted  ==============================================================
echo "as interpreted" | hooks_utility_padding_centered '='
printf '%s' "\n" | hooks_utility_padding_centered '-'
printf '%s' "\t" | hooks_utility_padding_centered '-'
