#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../scripts/hooks/hooks_utility.sh"

echo \
"tests: log style message, basic tests  #######################################\
##"

echo "Some Debugging Message Content" | hooks_utility_debug
echo "Content of Informational Message" | hooks_utility_info
echo "Warning!" | hooks_utility_warning
echo "Some Error Message" | hooks_utility_error
echo "Giving Critical Error Message" | hooks_utility_critical
