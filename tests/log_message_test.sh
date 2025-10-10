#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/hooks/hooks_utility.sh"

echo \
"tests for functions: Log Style Message  ########################################"

echo \
"log message of all types  ------------------------------------------------------"
hooks_utility_debug "Some Debugging Message Content"
hooks_utility_info "Content of Informational Message"
hooks_utility_warning "Warning!"
hooks_utility_error "Some Error Message"
hooks_utility_critical "Giving Critical Error Message"

