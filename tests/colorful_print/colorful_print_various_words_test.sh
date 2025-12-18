#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

hooks_utility_colorful_print_pass
printf '%b' "\n"

hooks_utility_colorful_print_fail
printf '%b' "\n"

hooks_utility_colorful_print_debug
printf '%b' "\n"

hooks_utility_colorful_print_info
printf '%b' "\n"

hooks_utility_colorful_print_warning
printf '%b' "\n"

hooks_utility_colorful_print_error
printf '%b' "\n"

hooks_utility_colorful_print_critical
printf '%b' "\n"
