#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

# test -N
printf "BEFORE"
echo "Title" | hooks_utility_padding_centered -N '-'
printf "AFTER\n"
