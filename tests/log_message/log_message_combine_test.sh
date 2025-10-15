#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../scripts/hooks/hooks_utility.sh"

echo \
"tests: log style message, combines args/optns  ###############################\
##"

echo \
"source & date  ---------------------------------------------------------------\
--"

echo "Some Debugging Message Content" | \
        hooks_utility_debug -d "MainComponent"
echo "Some Debugging Message Content" | \
        hooks_utility_debug -d "MainComponent"
echo "Content of Informational Message" | \
        hooks_utility_info -d "MainComponent"
echo "Warning!" | \
        hooks_utility_warning -d  "MainComponent"

echo \
"source & date-time  ----------------------------------------------------------\
--"

echo "Some Debugging Message Content" | \
        hooks_utility_debug -dt "Information Test Component from Main Script"
echo "Some Debugging Message Content" | \
        hooks_utility_debug -dt "Information Test Component from Main Script"
echo "Content of Informational Message" | \
        hooks_utility_info -dt "Information Test Component from Main Script"
echo "Warning!" | \
        hooks_utility_warning -dt "Information Test Component from Main Script"


echo \
"source & date & colors  ------------------------------------------------------\
--"

echo "Some Debugging Message Content" | \
        hooks_utility_debug -dc "MainComponent"

echo "Some Debugging Message Content" | \
        hooks_utility_debug -dC "MainComponent"