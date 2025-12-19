#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

echo 'log style tests: SOURCE argument' |
        hooks_utility_padding_centered '#'

echo "Some Debugging Message Content" | hooks_utility_debug "MainComponent"
echo "Content of Informational Message" | hooks_utility_info "abc def"
echo "Warning!" |
        hooks_utility_warning "Information Test Component from this Script"
echo "Some Error Message" | hooks_utility_error "abc.sh::function.foo()?"
