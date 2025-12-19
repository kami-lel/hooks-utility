#!/bin/bash

# fundamental tests for:
# hooks_utility_debug()
# hooks_utility_info()
# hooks_utility_warning()
# hooks_utility_error()
# hooks_utility_critical()

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

echo 'log style message, basic tests' | hooks_utility_padding_centered '#'

echo "Some Debugging Message Content" | hooks_utility_debug
echo "Content of Informational Message" | hooks_utility_info
echo "Warning!" | hooks_utility_warning
echo "Some Error Message" | hooks_utility_error
echo "Giving Critical Error Message" | hooks_utility_critical
