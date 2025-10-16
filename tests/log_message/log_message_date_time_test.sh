#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../scripts/hooks/hooks_utility.sh"

echo \
"tests: log style message, date & time  #######################################\
##"

echo \
"only date  -------------------------------------------------------------------\
--"

echo "Some Debugging Message Content" | hooks_utility_debug -d
echo "Content of Informational Message" | hooks_utility_info -d
echo "Warning!" | hooks_utility_warning -d

echo \
"only time  -------------------------------------------------------------------\
--"

echo "Some Error Message" | hooks_utility_error -t
echo "Giving Critical Error Message" | hooks_utility_critical -t

echo \
"date & time  -----------------------------------------------------------------\
--"

echo "Some Debugging Message Content" | hooks_utility_debug -dt
echo "Content of Informational Message" | hooks_utility_info -td
echo "Warning!" | hooks_utility_warning -d -t