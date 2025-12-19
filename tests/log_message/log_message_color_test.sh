#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

tmp=$(mktemp)

echo "log style message test on -c/-C" | hooks_utility_padding_centered '#'

# BUG bad coloring

# ENABLE_ANSI_COLOR=1  #########################################################
echo "ENABLE_ANSI_COLOR=1" | hooks_utility_padding_centered '#'
enable_ansi_color_default="${ENABLE_ANSI_COLOR}"
export ENABLE_ANSI_COLOR=1

# default to terminal  ---------------------------------------------------------
echo "default to terminal" | hooks_utility_padding_centered '-'
echo "Debug Message Content" | hooks_utility_debug
echo "Enter Message Content" | hooks_utility_enter
echo "Info Message Content" | hooks_utility_info
echo "Pass Message Content" | hooks_utility_pass
echo "Warning Message Content" | hooks_utility_warning
echo "Error Message Content" | hooks_utility_error
echo "Fail Message Content" | hooks_utility_fail
echo "Critical Message Content" | hooks_utility_critical

# default to file  -------------------------------------------------------------
echo "default to file" | hooks_utility_padding_centered '-'

echo "Debug Message Content" | hooks_utility_debug 1>"${tmp}"
cat "${tmp}"

echo "Enter Message Content" | hooks_utility_enter 1>"${tmp}"
cat "${tmp}"

echo "Info Message Content" | hooks_utility_info 1>"${tmp}"
cat "${tmp}"

echo "Pass Message Content" | hooks_utility_pass 1>"${tmp}"
cat "${tmp}"

# BUG
echo "Warning Message Content" | hooks_utility_warning 2>"${tmp}"
cat "${tmp}"

echo "Error Message Content" | hooks_utility_error 2>"${tmp}"
cat "${tmp}"

echo "Fail Message Content" | hooks_utility_fail 2>"${tmp}"
cat "${tmp}"

echo "Critical Message Content" | hooks_utility_critical 2>"${tmp}"
cat "${tmp}"

# use -c  ======================================================================
echo "use -c" | hooks_utility_padding_centered '='

# to terminal  -----------------------------------------------------------------
echo "to terminal" | hooks_utility_padding_centered '-'
echo "Debug Message Content" | hooks_utility_debug -c
echo "Warning Message Content" | hooks_utility_warning -c

# to file  ---------------------------------------------------------------------
echo "to file" | hooks_utility_padding_centered '-'

echo "Enter Message Content" | hooks_utility_enter -c 1>"${tmp}"
cat "${tmp}"

echo "Error Message Content" | hooks_utility_error -c 2>"${tmp}"
cat "${tmp}"

# use -C  ======================================================================
echo "use -C" | hooks_utility_padding_centered '='

# to terminal  -----------------------------------------------------------------
echo "to terminal" | hooks_utility_padding_centered '-'
echo "Info Message Content" | hooks_utility_info -C
echo "Fail Message Content" | hooks_utility_fail -C

# to file  ---------------------------------------------------------------------
echo "to file" | hooks_utility_padding_centered '-'

echo "Pass Message Content" | hooks_utility_pass -C 1>"${tmp}"
cat "${tmp}"

echo "Critical Message Content" | hooks_utility_critical -C 2>"${tmp}"
cat "${tmp}"

# ENABLE_ANSI_COLOR=0  #########################################################
echo "ENABLE_ANSI_COLOR=0" | hooks_utility_padding_centered '#'
export ENABLE_ANSI_COLOR=0

# default to terminal  ---------------------------------------------------------
echo "default to terminal" | hooks_utility_padding_centered '-'
echo "Debug Message Content" | hooks_utility_debug
echo "Info Message Content" | hooks_utility_info
echo "Warning Message Content" | hooks_utility_warning
echo "Fail Message Content" | hooks_utility_fail

# default to file  -------------------------------------------------------------
echo "default to file" | hooks_utility_padding_centered '-'

echo "Enter Message Content" | hooks_utility_enter 1>"${tmp}"
cat "${tmp}"

echo "Pass Message Content" | hooks_utility_pass 1>"${tmp}"
cat "${tmp}"

echo "Error Message Content" | hooks_utility_error 2>"${tmp}"
cat "${tmp}"

echo "Critical Message Content" | hooks_utility_critical 2>"${tmp}"
cat "${tmp}"

# use -c  ======================================================================
echo "use -c" | hooks_utility_padding_centered '='

# to terminal  -----------------------------------------------------------------
echo "to terminal" | hooks_utility_padding_centered '-'
echo "Debug Message Content" | hooks_utility_debug -c
echo "Warning Message Content" | hooks_utility_warning -c

# to file  ---------------------------------------------------------------------
echo "to file" | hooks_utility_padding_centered '-'

echo "Enter Message Content" | hooks_utility_enter -c 1>"${tmp}"
cat "${tmp}"

echo "Error Message Content" | hooks_utility_error -c 2>"${tmp}"
cat "${tmp}"

# use -C  ======================================================================
echo "use -C" | hooks_utility_padding_centered '='

# to terminal  -----------------------------------------------------------------
echo "to terminal" | hooks_utility_padding_centered '-'
echo "Info Message Content" | hooks_utility_info -C
echo "Fail Message Content" | hooks_utility_fail -C

# to file  ---------------------------------------------------------------------
echo "to file" | hooks_utility_padding_centered '-'

echo "Pass Message Content" | hooks_utility_pass -C 1>"${tmp}"
cat "${tmp}"

echo "Critical Message Content" | hooks_utility_critical -C 2>"${tmp}"
cat "${tmp}"

export ENABLE_ANSI_COLOR="${enable_ansi_color_default}"
