#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/hooks/hooks_utility.sh"

echo \
"tests: log style message, date & time  #######################################\
##"

echo \
"only date  -------------------------------------------------------------------\
--"

hooks_utility_debug "Some Debugging Message Content" -d
hooks_utility_info "Content of Informational Message" -d
hooks_utility_warning -d "Warning!"

echo \
"only time  -------------------------------------------------------------------\
--"

hooks_utility_error "Some Error Message" -t
hooks_utility_critical -t "Giving Critical Error Message"

echo \
"date & time  -----------------------------------------------------------------\
--"

hooks_utility_debug "Some Debugging Message Content" -dt
hooks_utility_info "Content of Informational Message" -td
hooks_utility_warning "Warning!" -d -t
hooks_utility_error -t -d "Some Error Message"