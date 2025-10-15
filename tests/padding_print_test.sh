#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/hooks/hooks_utility.sh"

echo \
"tests: padding print, basic  #################################################\
##"

echo "left just w/ #:"
echo "Title" | hooks_utility_padding_left_just "#"

echo "right just w/ =:"
echo "Some Information" | hooks_utility_padding_right_just "="

echo "centered w/ *:"
echo "Centered Heading" | hooks_utility_padding_centered "*"

echo "centered w/ odd width:"
echo "Centering Heading" | hooks_utility_padding_centered "-"

echo \
"very long message  ===========================================================\
=="

# left but message too long
echo "\
Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus \
ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus \
duis." | hooks_utility_padding_left_just "#"

# centered but message too long
echo "\
Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex \
sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus \
duis." | hooks_utility_padding_centered "="

# left, just enough
echo "Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibu \
eaibr" | hooks_utility_padding_left_just "-"

# centered just enough
echo "Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibu \
ex" | hooks_utility_padding_centered "="


echo \
"test coloring  ===============================================================\
=="

# TODO

echo \
"test -N  =====================================================================\
=="

printf "BEFORE"
echo "Title" | hooks_utility_padding_centered -N '-'
printf "AFTER"