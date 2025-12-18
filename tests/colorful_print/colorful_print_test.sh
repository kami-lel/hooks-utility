#!/bin/bash

# test scrip for:
# hooks_utility_colorful_print()

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

# Regular Color  ---------------------------------------------------------------
echo "Regular Color" | hooks_utility_padding_left_just "-"
printf '%s' "Regular Black\n" | hooks_utility_colorful_print "\e[0;30m"
printf '%s' "Regular Red\n" | hooks_utility_colorful_print "\e[0;31m"
printf '%s' "Regular Green\n" | hooks_utility_colorful_print "\e[0;32m"
printf '%s' "Regular Yellow\n" | hooks_utility_colorful_print "\e[0;33m"
printf '%s' "Regular Blue\n" | hooks_utility_colorful_print "\e[0;34m"
printf '%s' "Regular Purple\n" | hooks_utility_colorful_print "\e[0;35m"
printf '%s' "Regular Cyan\n" | hooks_utility_colorful_print "\e[0;36m"
printf '%s' "Regular White\n" | hooks_utility_colorful_print "\e[0;37m"

# Bold  ------------------------------------------------------------------------
echo "Bold" | hooks_utility_padding_left_just "-"
printf '%s' "Bold Black\n" | hooks_utility_colorful_print "\e[1;30m"
printf '%s' "Bold Red\n" | hooks_utility_colorful_print "\e[1;31m"
printf '%s' "Bold Green\n" | hooks_utility_colorful_print "\e[1;32m"
printf '%s' "Bold Yellow\n" | hooks_utility_colorful_print "\e[1;33m"
printf '%s' "Bold Blue\n" | hooks_utility_colorful_print "\e[1;34m"
printf '%s' "Bold Purple\n" | hooks_utility_colorful_print "\e[1;35m"
printf '%s' "Bold Cyan\n" | hooks_utility_colorful_print "\e[1;36m"
printf '%s' "Bold White\n" | hooks_utility_colorful_print "\e[1;37m"

# Underline  -------------------------------------------------------------------
echo "Underline" | hooks_utility_padding_left_just "-"
printf '%s' "Underline Black\n" | hooks_utility_colorful_print "\e[4;30m"
printf '%s' "Underline Red\n" | hooks_utility_colorful_print "\e[4;31m"
printf '%s' "Underline Green\n" | hooks_utility_colorful_print "\e[4;32m"
printf '%s' "Underline Yellow\n" | hooks_utility_colorful_print "\e[4;33m"
printf '%s' "Underline Blue\n" | hooks_utility_colorful_print "\e[4;34m"
printf '%s' "Underline Purple\n" | hooks_utility_colorful_print "\e[4;35m"
printf '%s' "Underline Cyan\n" | hooks_utility_colorful_print "\e[4;36m"
printf '%s' "Underline White\n" | hooks_utility_colorful_print "\e[4;37m"

# Background  ------------------------------------------------------------------
echo "Background" | hooks_utility_padding_left_just "-"
printf '%s' "Background Black\n" | hooks_utility_colorful_print "\e[40m"
printf '%s' "Background Red\n" | hooks_utility_colorful_print "\e[41m"
printf '%s' "Background Green\n" | hooks_utility_colorful_print "\e[42m"
printf '%s' "Background Yellow\n" | hooks_utility_colorful_print "\e[43m"
printf '%s' "Background Blue\n" | hooks_utility_colorful_print "\e[44m"
printf '%s' "Background Purple\n" | hooks_utility_colorful_print "\e[45m"
printf '%s' "Background Cyan\n" | hooks_utility_colorful_print "\e[46m"
printf '%s' "Background White\n" | hooks_utility_colorful_print "\e[47m"

# High Intensity  --------------------------------------------------------------
echo "High Intensity" | hooks_utility_padding_left_just "-"
printf '%s' "High Intensity Black\n" | hooks_utility_colorful_print "\e[0;90m"
printf '%s' "High Intensity Red\n" | hooks_utility_colorful_print "\e[0;91m"
printf '%s' "High Intensity Green\n" | hooks_utility_colorful_print "\e[0;92m"
printf '%s' "High Intensity Yellow\n" | hooks_utility_colorful_print "\e[0;93m"
printf '%s' "High Intensity Blue\n" | hooks_utility_colorful_print "\e[0;94m"
printf '%s' "High Intensity Purple\n" | hooks_utility_colorful_print "\e[0;95m"
printf '%s' "High Intensity Cyan\n" | hooks_utility_colorful_print "\e[0;96m"
printf '%s' "High Intensity White\n" | hooks_utility_colorful_print "\e[0;97m"

# Bold High Intensity  ---------------------------------------------------------
echo "Bold High Intensity" | hooks_utility_padding_left_just "-"
printf '%s' "Bold High Intensity Black\n" |
    hooks_utility_colorful_print "\e[1;90m"
printf '%s' "Bold High Intensity Red\n" |
    hooks_utility_colorful_print "\e[1;91m"
printf '%s' "Bold High Intensity Green\n" |
    hooks_utility_colorful_print "\e[1;92m"
printf '%s' "Bold High Intensity Yellow\n" |
    hooks_utility_colorful_print "\e[1;93m"
printf '%s' "Bold High Intensity Blue\n" |
    hooks_utility_colorful_print "\e[1;94m"
printf '%s' "Bold High Intensity Purple\n" |
    hooks_utility_colorful_print "\e[1;95m"
printf '%s' "Bold High Intensity Cyan\n" |
    hooks_utility_colorful_print "\e[1;96m"
printf '%s' "Bold High Intensity White\n" |
    hooks_utility_colorful_print "\e[1;97m"

# High Intensity backgrounds  --------------------------------------------------
echo "High Intensity backgrounds" | hooks_utility_padding_left_just "-"
printf '%s' "High Intensity backgrounds Black\n" |
    hooks_utility_colorful_print "\e[0;100m"
printf '%s' "High Intensity backgrounds Red\n" |
    hooks_utility_colorful_print "\e[0;101m"
printf '%s' "High Intensity backgrounds Green\n" |
    hooks_utility_colorful_print "\e[0;102m"
printf '%s' "High Intensity backgrounds Yellow\n" |
    hooks_utility_colorful_print "\e[0;103m"
printf '%s' "High Intensity backgrounds Blue\n" |
    hooks_utility_colorful_print "\e[0;104m"
printf '%s' "High Intensity backgrounds Purple\n" |
    hooks_utility_colorful_print "\e[0;105m"
printf '%s' "High Intensity backgrounds Cyan\n" |
    hooks_utility_colorful_print "\e[0;106m"
printf '%s' "High Intensity backgrounds White\n" |
    hooks_utility_colorful_print "\e[0;107m"
