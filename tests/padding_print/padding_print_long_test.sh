#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../scripts/hooks/hooks_utility.sh"

echo \
"tests: padding print, very long message  #####################################\
##"


hooks_utility_info "left but message too long"
hooks_utility_padding_left_just "#" "\
Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex \
sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis."

hooks_utility_info "centered but message too long"
hooks_utility_padding_centered "=" "\
Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex \
sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis."

hooks_utility_info "left, just enough"
hooks_utility_padding_left_just "-" "\
Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibu eaibr"

hooks_utility_info "centered just enough"
hooks_utility_padding_centered "=" "\
Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibu ex"