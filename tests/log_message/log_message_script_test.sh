#!/bin/bash

# tests for:
# hooks_utility_enter()
# hooks_utility_pass()
# hooks_utility_fail

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

# basic  =======================================================================
echo 'log style message, test enter/pass/fail' |
    hooks_utility_padding_left_just '#'
echo 'basic' | hooks_utility_padding_left_just '='

echo "Enter Some Script" | hooks_utility_enter
echo "Finish Some Script" | hooks_utility_pass
echo "Fail Some Script" | hooks_utility_fail

# combined  ====================================================================
echo "combined" | hooks_utility_padding_left_just '='

# source & date  ---------------------------------------------------------------
echo "source & date" | hooks_utility_padding_left_just '-'
echo "Enter Some Script" | hooks_utility_enter -d "MainComponent"
echo "Pass Some Script" | hooks_utility_pass -d "MainComponent"
echo "Fail Some Script" | hooks_utility_fail -d "MainComponent"

# source & date-time  ----------------------------------------------------------
echo "source & date-time" | hooks_utility_padding_left_just '-'

echo "Enter Some Script" |
    hooks_utility_enter -dt "Information Test Component from Main Script"
echo "Pass Some Script" |
    hooks_utility_pass -dt "Information Test Component from Main Script"
echo "Fail Some Script" |
    hooks_utility_fail -dt "Information Test Component from Main Script"

# source & date-time & colors  -------------------------------------------------
echo "source & date & colors" | hooks_utility_padding_left_just '-'

echo "Enter Some Script" |
    hooks_utility_enter -dc "MainComponent"
echo "Pass Some Script" |
    hooks_utility_pass -dc "MainComponent"
echo "Fail Some Script" |
    hooks_utility_fail -dc "MainComponent"
