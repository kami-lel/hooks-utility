#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

echo "log style message tests:combines args" | hooks_utility_padding_centered '#'

# source & date  ---------------------------------------------------------------
echo "source & date" | hooks_utility_padding_centered '-'

echo "Some Debugging Message Content" |
        hooks_utility_debug -d "MainComponent"
echo "Some Debugging Message Content" |
        hooks_utility_debug -d "MainComponent"
echo "Content of Informational Message" |
        hooks_utility_info -d "MainComponent"
echo "Warning!" |
        hooks_utility_warning -d "MainComponent"

# source & date-time  ----------------------------------------------------------
echo "source & date-time" | hooks_utility_padding_centered '-'

echo "Some Debugging Message Content" |
        hooks_utility_debug -dt "Information Test Component from Main Script"
echo "Some Debugging Message Content" |
        hooks_utility_debug -dt "Information Test Component from Main Script"
echo "Content of Informational Message" |
        hooks_utility_info -dt "Information Test Component from Main Script"
echo "Warning!" |
        hooks_utility_warning -dt "Information Test Component from Main Script"

# source & date & color  -------------------------------------------------------
echo "source & date & color" | hooks_utility_padding_centered '-'

echo "Some Debugging Message Content" |
        hooks_utility_debug -dc "MainComponent"

echo "Some Debugging Message Content No Color" |
        hooks_utility_debug -dC "MainComponent"
