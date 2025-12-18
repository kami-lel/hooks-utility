#!/bin/bash

# test scrip for:
# hooks_utility_colorful_print()

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

# TODO various codes
printf "content in RED\n" | hooks_utility_colorful_print "\e[0;31m"
printf "content in GREEN\n" | hooks_utility_colorful_print "\e[0;32m"
printf "content in Cyan Underline\n" | hooks_utility_colorful_print "\e[4;36m"
