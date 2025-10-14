#!/bin/bash

PADDING_TEST_NAME='padding_print_test.sh'

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/hooks/hooks_utility.sh"

echo \
"tests: padding print  ########################################################\
##"


hooks_utility_info "left just w/ #" "${PADDING_TEST_NAME}"
hooks_utility_padding_left_just "#" "Title"

hooks_utility_info "right just w/ =" "${PADDING_TEST_NAME}"
hooks_utility_padding_right_just "=" "Some Information"

hooks_utility_info "centered w/ *" "${PADDING_TEST_NAME}"
hooks_utility_padding_centered "*" "Centered Heading"

hooks_utility_info "centered w/ odd width" "${PADDING_TEST_NAME}"
hooks_utility_padding_centered "-" "Centering Heading"

hooks_utility_info "edge case, message too long" "${PADDING_TEST_NAME}"
hooks_utility_padding_centered "=" "\
Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex \
sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis."
