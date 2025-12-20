#!/bin/bash

# tests for -D

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

echo 'log style tests: -D flag' | hooks_utility_padding_centered '#'

# LOGGING_LEVEL=0  =============================================================
echo "LOGGING_LEVEL=0" | hooks_utility_padding_centered '#'
logging_level_default="${LOGGING_LEVEL}"
export LOGGING_LEVEL=0

echo "Some Debugging Message Content" | hooks_utility_debug -D
echo "Content of Informational Message" | hooks_utility_info -D
echo "Warning!" | hooks_utility_warning -D
echo "Some Error Message" | hooks_utility_error -D
echo "Giving Critical Error Message" | hooks_utility_critical -D
echo "Enter Some Script" | hooks_utility_enter -D
echo "Finish Some Script" | hooks_utility_pass -D
echo "Fail Some Script" | hooks_utility_fail -D

# LOGGING_LEVEL=10  ============================================================
echo "LOGGING_LEVEL=10" | hooks_utility_padding_centered '#'
export LOGGING_LEVEL=10

echo "Some Debugging Message Content" | hooks_utility_debug -D
echo "Content of Informational Message" | hooks_utility_info -D
echo "Warning!" | hooks_utility_warning -D
echo "Some Error Message" | hooks_utility_error -D
echo "Giving Critical Error Message" | hooks_utility_critical -D
echo "Enter Some Script" | hooks_utility_enter -D
echo "Finish Some Script" | hooks_utility_pass -D
echo "Fail Some Script" | hooks_utility_fail -D

# LOGGING_LEVEL=20  ============================================================
echo "LOGGING_LEVEL=20" | hooks_utility_padding_centered '#'
export LOGGING_LEVEL=20

echo "Some Debugging Message Content" | hooks_utility_debug -D
echo "Content of Informational Message" | hooks_utility_info -D
echo "Warning!" | hooks_utility_warning -D
echo "Some Error Message" | hooks_utility_error -D
echo "Giving Critical Error Message" | hooks_utility_critical -D
echo "Enter Some Script" | hooks_utility_enter -D
echo "Finish Some Script" | hooks_utility_pass -D
echo "Fail Some Script" | hooks_utility_fail -D

# LOGGING_LEVEL=30  ============================================================
echo "LOGGING_LEVEL=30" | hooks_utility_padding_centered '#'
export LOGGING_LEVEL=30

echo "Some Debugging Message Content" | hooks_utility_debug -D
echo "Content of Informational Message" | hooks_utility_info -D
echo "Warning!" | hooks_utility_warning -D
echo "Some Error Message" | hooks_utility_error -D
echo "Giving Critical Error Message" | hooks_utility_critical -D
echo "Enter Some Script" | hooks_utility_enter -D
echo "Finish Some Script" | hooks_utility_pass -D
echo "Fail Some Script" | hooks_utility_fail -D

export LOGGING_LEVEL="${logging_level_default}"
