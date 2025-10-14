#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../scripts/hooks/hooks_utility.sh"

echo \
"tests: padding print, basic  #################################################\
##"

hooks_utility_info "left just w/ #"


hooks_utility_info "left just w/ #"
hooks_utility_padding_left_just "#" "Title"

hooks_utility_info "right just w/ ="
hooks_utility_padding_right_just "=" "Some Information"

hooks_utility_info "centered w/ *"
hooks_utility_padding_centered "*" "Centered Heading"

hooks_utility_info "centered w/ odd width"
hooks_utility_padding_centered "-" "Centering Heading"
