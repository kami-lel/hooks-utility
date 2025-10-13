#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/hooks/hooks_utility.sh"

echo \
"tests: log style message, date & time  #######################################\
##"

echo \
"only date  -------------------------------------------------------------------\
--"

hooks_utility_debug -d "Some Debugging Message Content"
hooks_utility_info -d "Content of Informational Message"
hooks_utility_warning -d "Warning!"

echo \
"only time  -------------------------------------------------------------------\
--"

hooks_utility_error -t "Some Error Message"
hooks_utility_critical -t "Giving Critical Error Message"

echo \
"date & time  -----------------------------------------------------------------\
--"

hooks_utility_debug -dt "Some Debugging Message Content"
hooks_utility_info -td "Content of Informational Message"
hooks_utility_warning -d -t "Warning!"