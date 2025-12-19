#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

# left, just enough
echo "Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibu \
eaibr" | hooks_utility_padding_left_just "-"

# centered just enough
echo "Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibu \
ex" | hooks_utility_padding_centered "="
