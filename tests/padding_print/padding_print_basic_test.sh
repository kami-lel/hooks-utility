#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

echo "left just w/ #:"
echo "Title" | hooks_utility_padding_left_just "#"

echo "right just w/ =:"
echo "Some Information" | hooks_utility_padding_right_just "="

echo "centered w/ *:"
echo "Centered Heading" | hooks_utility_padding_centered "*"

echo "centered w/ odd width:"
echo "Centering Heading" | hooks_utility_padding_centered "-"
