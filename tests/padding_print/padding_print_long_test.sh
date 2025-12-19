#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

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
