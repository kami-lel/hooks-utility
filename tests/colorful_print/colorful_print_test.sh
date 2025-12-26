#!/bin/bash

# test scrip for:
# hooks_utility_colorful_print()

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

# BUG \n is lost

# Regular Color  ---------------------------------------------------------------
echo "Regular Color" | hooks_utility_padding_left_just "-"

printf '%s\n' "Regular Black" | hooks_utility_colorful_print "\e[0;30m"
printf '%s\n' "Regular Red" | hooks_utility_colorful_print "\e[0;31m"
printf '%s\n' "Regular Green" | hooks_utility_colorful_print "\e[0;32m"
printf '%s\n' "Regular Yellow" | hooks_utility_colorful_print "\e[0;33m"
printf '%s\n' "Regular Blue" | hooks_utility_colorful_print "\e[0;34m"
printf '%s\n' "Regular Purple" | hooks_utility_colorful_print "\e[0;35m"
printf '%s\n' "Regular Cyan" | hooks_utility_colorful_print "\e[0;36m"
printf '%s\n' "Regular White" | hooks_utility_colorful_print "\e[0;37m"

# Bold  ------------------------------------------------------------------------
echo "Bold" | hooks_utility_padding_left_just "-"

printf '%s\n' "Bold Black" | hooks_utility_colorful_print "\e[1;30m"
printf '%s\n' "Bold Red" | hooks_utility_colorful_print "\e[1;31m"
printf '%s\n' "Bold Green" | hooks_utility_colorful_print "\e[1;32m"
printf '%s\n' "Bold Yellow" | hooks_utility_colorful_print "\e[1;33m"
printf '%s\n' "Bold Blue" | hooks_utility_colorful_print "\e[1;34m"
printf '%s\n' "Bold Purple" | hooks_utility_colorful_print "\e[1;35m"
printf '%s\n' "Bold Cyan" | hooks_utility_colorful_print "\e[1;36m"
printf '%s\n' "Bold White" | hooks_utility_colorful_print "\e[1;37m"

# Underline  -------------------------------------------------------------------
echo "Underline" | hooks_utility_padding_left_just "-"

printf '%s\n' "Underline Black" | hooks_utility_colorful_print "\e[4;30m"
printf '%s\n' "Underline Red" | hooks_utility_colorful_print "\e[4;31m"
printf '%s\n' "Underline Green" | hooks_utility_colorful_print "\e[4;32m"
printf '%s\n' "Underline Yellow" | hooks_utility_colorful_print "\e[4;33m"
printf '%s\n' "Underline Blue" | hooks_utility_colorful_print "\e[4;34m"
printf '%s\n' "Underline Purple" | hooks_utility_colorful_print "\e[4;35m"
printf '%s\n' "Underline Cyan" | hooks_utility_colorful_print "\e[4;36m"
printf '%s\n' "Underline White" | hooks_utility_colorful_print "\e[4;37m"

# Background  ------------------------------------------------------------------
echo "Background" | hooks_utility_padding_left_just "-"

printf '%s\n' "Background Black" | hooks_utility_colorful_print "\e[40m"
printf '%s\n' "Background Red" | hooks_utility_colorful_print "\e[41m"
printf '%s\n' "Background Green" | hooks_utility_colorful_print "\e[42m"
printf '%s\n' "Background Yellow" | hooks_utility_colorful_print "\e[43m"
printf '%s\n' "Background Blue" | hooks_utility_colorful_print "\e[44m"
printf '%s\n' "Background Purple" | hooks_utility_colorful_print "\e[45m"
printf '%s\n' "Background Cyan" | hooks_utility_colorful_print "\e[46m"
printf '%s\n' "Background White" | hooks_utility_colorful_print "\e[47m"

# High Intensity  --------------------------------------------------------------
echo "High Intensity" | hooks_utility_padding_left_just "-"

printf '%s\n' "High Intensity Black" | hooks_utility_colorful_print "\e[0;90m"
printf '%s\n' "High Intensity Red" | hooks_utility_colorful_print "\e[0;91m"
printf '%s\n' "High Intensity Green" | hooks_utility_colorful_print "\e[0;92m"
printf '%s\n' "High Intensity Yellow" | hooks_utility_colorful_print "\e[0;93m"
printf '%s\n' "High Intensity Blue" | hooks_utility_colorful_print "\e[0;94m"
printf '%s\n' "High Intensity Purple" | hooks_utility_colorful_print "\e[0;95m"
printf '%s\n' "High Intensity Cyan" | hooks_utility_colorful_print "\e[0;96m"
printf '%s\n' "High Intensity White" | hooks_utility_colorful_print "\e[0;97m"

# Bold High Intensity  ---------------------------------------------------------
echo "Bold High Intensity" | hooks_utility_padding_left_just "-"

printf '%s\n' "Bold High Intensity Black" |
    hooks_utility_colorful_print "\e[1;90m"
printf '%s\n' "Bold High Intensity Red" |
    hooks_utility_colorful_print "\e[1;91m"
printf '%s\n' "Bold High Intensity Green" |
    hooks_utility_colorful_print "\e[1;92m"
printf '%s\n' "Bold High Intensity Yellow" |
    hooks_utility_colorful_print "\e[1;93m"
printf '%s\n' "Bold High Intensity Blue" |
    hooks_utility_colorful_print "\e[1;94m"
printf '%s\n' "Bold High Intensity Purple" |
    hooks_utility_colorful_print "\e[1;95m"
printf '%s\n' "Bold High Intensity Cyan" |
    hooks_utility_colorful_print "\e[1;96m"
printf '%s\n' "Bold High Intensity White" |
    hooks_utility_colorful_print "\e[1;97m"

# High Intensity backgrounds  --------------------------------------------------
echo "High Intensity backgrounds" | hooks_utility_padding_left_just "-"

printf '%s\n' "High Intensity backgrounds Black" |
    hooks_utility_colorful_print "\e[0;100m"
printf '%s\n' "High Intensity backgrounds Red" |
    hooks_utility_colorful_print "\e[0;101m"
printf '%s\n' "High Intensity backgrounds Green" |
    hooks_utility_colorful_print "\e[0;102m"
printf '%s\n' "High Intensity backgrounds Yellow" |
    hooks_utility_colorful_print "\e[0;103m"
printf '%s\n' "High Intensity backgrounds Blue" |
    hooks_utility_colorful_print "\e[0;104m"
printf '%s\n' "High Intensity backgrounds Purple" |
    hooks_utility_colorful_print "\e[0;105m"
printf '%s\n' "High Intensity backgrounds Cyan" |
    hooks_utility_colorful_print "\e[0;106m"
printf '%s\n' "High Intensity backgrounds White" |
    hooks_utility_colorful_print "\e[0;107m"
