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

printf '%s' "Content in Black\n" | hooks_utility_print_in_black
printf '%s' "Content in Red\n" | hooks_utility_print_in_red
printf '%s' "Content in Green\n" | hooks_utility_print_in_green
printf '%s' "Content in Yellow\n" | hooks_utility_print_in_yellow
printf '%s' "Content in Blue\n" | hooks_utility_print_in_blue
printf '%s' "Content in Purple\n" | hooks_utility_print_in_purple
printf '%s' "Content in Cyan\n" | hooks_utility_print_in_cyan
printf '%s' "Content in White\n" | hooks_utility_print_in_white
