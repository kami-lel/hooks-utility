#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

echo "log style tests:date & time" | hooks_utility_padding_centered '#'

# only date  -------------------------------------------------------------------
echo "only date" | hooks_utility_padding_centered '-'

echo "Some Debugging Message Content" | hooks_utility_debug -d
echo "Content of Informational Message" | hooks_utility_info -d
echo "Warning!" | hooks_utility_warning -d

# only time  -------------------------------------------------------------------
echo "only time" | hooks_utility_padding_centered '-'

echo "Some Error Message" | hooks_utility_error -t
echo "Giving Critical Error Message" | hooks_utility_critical -t

# date & time  -----------------------------------------------------------------
echo "date & time" | hooks_utility_padding_centered '-'

echo "Some Debugging Message Content" | hooks_utility_debug -dt
echo "Content of Informational Message" | hooks_utility_info -td
echo "Warning!" | hooks_utility_warning -d -t
