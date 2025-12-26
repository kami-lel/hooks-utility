#!/bin/bash

# test special character of hooks_utility_colorful_print()

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

echo "special character tests" | hooks_utility_padding_centered '#'
# as literal  ==================================================================
echo "as literal" | hooks_utility_padding_centered '='

# \n  --------------------------------------------------------------------------
printf '%s' "\n" | hooks_utility_padding_centered '-'
printf 'AAAAA%sZZZZZ' "\n" | hooks_utility_info

# \t  --------------------------------------------------------------------------
printf '%s' "\t" | hooks_utility_padding_centered '-'
printf 'AAAAA%sZZZZZ' "\t" | hooks_utility_error

# as interpreted  ==============================================================
echo "as interpreted" | hooks_utility_padding_centered '='
# \n  --------------------------------------------------------------------------
printf '%s' "\n" | hooks_utility_padding_centered '-'
printf 'AAAAA%bZZZZZ' "\n" | hooks_utility_info

# \t  --------------------------------------------------------------------------
printf '%s' "\t" | hooks_utility_padding_centered '-'
printf 'AAAAA%bZZZZZ' "\t" | hooks_utility_error
