#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/hooks/hooks_utility.sh"

echo \
"tests: log style message, SOURCE argument  ###################################\
##"

hooks_utility_debug "Some Debugging Message Content" "MainComponent"
hooks_utility_info "Content of Informational Message" "abc def"
hooks_utility_warning "Warning!" "Information Test Component from this Script"
hooks_utility_error "Some Error Message" "abc.sh::function.foo()?"

echo \
"combined w/ date time  -------------------------------------------------------\
--"

hooks_utility_debug "Some Debugging Message Content" "MainComponent" -d
hooks_utility_warning -dt \
        "Warning!" "Information Test Component from this Script"