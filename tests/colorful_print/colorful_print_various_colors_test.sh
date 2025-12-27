#!/bin/bash

# test scrip for:
# hooks_utility_print_in_black()
# hooks_utility_print_in_red()
# hooks_utility_print_in_green()
# hooks_utility_print_in_yellow()
# hooks_utility_print_in_blue()
# hooks_utility_print_in_purple()
# hooks_utility_print_in_cyan()
# hooks_utility_print_in_white()

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

printf '%s' "Content in Black" | hooks_utility_print_in_black
printf '\n'
printf '%s' "Content in Red" | hooks_utility_print_in_red
printf '\n'
printf '%s' "Content in Green" | hooks_utility_print_in_green
printf '\n'
printf '%s' "Content in Yellow" | hooks_utility_print_in_yellow
printf '\n'
printf '%s' "Content in Blue" | hooks_utility_print_in_blue
printf '\n'
printf '%s' "Content in Purple" | hooks_utility_print_in_purple
printf '\n'
printf '%s' "Content in Cyan" | hooks_utility_print_in_cyan
printf '\n'
printf '%s' "Content in White" | hooks_utility_print_in_white
printf '\n'
