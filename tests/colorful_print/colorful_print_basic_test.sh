#!/bin/bash

# test scrip for:
# hooks_utility_colorful_print()

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

# Regular Color  ---------------------------------------------------------------
echo "Regular Color" | hooks_utility_padding_centered "-"

printf '%s' "Regular Black" | hooks_utility_colorful_print "\e[0;30m"
printf '\n'
printf '%s' "Regular Red" | hooks_utility_colorful_print "\e[0;31m"
printf '\n'
printf '%s' "Regular Green" | hooks_utility_colorful_print "\e[0;32m"
printf '\n'
printf '%s' "Regular Yellow" | hooks_utility_colorful_print "\e[0;33m"
printf '\n'
printf '%s' "Regular Blue" | hooks_utility_colorful_print "\e[0;34m"
printf '\n'
printf '%s' "Regular Purple" | hooks_utility_colorful_print "\e[0;35m"
printf '\n'
printf '%s' "Regular Cyan" | hooks_utility_colorful_print "\e[0;36m"
printf '\n'
printf '%s' "Regular White" | hooks_utility_colorful_print "\e[0;37m"
printf '\n'

# Bold  ------------------------------------------------------------------------
echo "Bold" | hooks_utility_padding_centered "-"

printf '%s' "Bold Black" | hooks_utility_colorful_print "\e[1;30m"
printf '\n'
printf '%s' "Bold Red" | hooks_utility_colorful_print "\e[1;31m"
printf '\n'
printf '%s' "Bold Green" | hooks_utility_colorful_print "\e[1;32m"
printf '\n'
printf '%s' "Bold Yellow" | hooks_utility_colorful_print "\e[1;33m"
printf '\n'
printf '%s' "Bold Blue" | hooks_utility_colorful_print "\e[1;34m"
printf '\n'
printf '%s' "Bold Purple" | hooks_utility_colorful_print "\e[1;35m"
printf '\n'
printf '%s' "Bold Cyan" | hooks_utility_colorful_print "\e[1;36m"
printf '\n'
printf '%s' "Bold White" | hooks_utility_colorful_print "\e[1;37m"
printf '\n'

# Underline  -------------------------------------------------------------------
echo "Underline" | hooks_utility_padding_centered "-"

printf '%s' "Underline Black" | hooks_utility_colorful_print "\e[4;30m"
printf '\n'
printf '%s' "Underline Red" | hooks_utility_colorful_print "\e[4;31m"
printf '\n'
printf '%s' "Underline Green" | hooks_utility_colorful_print "\e[4;32m"
printf '\n'
printf '%s' "Underline Yellow" | hooks_utility_colorful_print "\e[4;33m"
printf '\n'
printf '%s' "Underline Blue" | hooks_utility_colorful_print "\e[4;34m"
printf '\n'
printf '%s' "Underline Purple" | hooks_utility_colorful_print "\e[4;35m"
printf '\n'
printf '%s' "Underline Cyan" | hooks_utility_colorful_print "\e[4;36m"
printf '\n'
printf '%s' "Underline White" | hooks_utility_colorful_print "\e[4;37m"
printf '\n'

# Background  ------------------------------------------------------------------
echo "Background" | hooks_utility_padding_centered "-"

printf '%s' "Background Black" | hooks_utility_colorful_print "\e[40m"
printf '\n'
printf '%s' "Background Red" | hooks_utility_colorful_print "\e[41m"
printf '\n'
printf '%s' "Background Green" | hooks_utility_colorful_print "\e[42m"
printf '\n'
printf '%s' "Background Yellow" | hooks_utility_colorful_print "\e[43m"
printf '\n'
printf '%s' "Background Blue" | hooks_utility_colorful_print "\e[44m"
printf '\n'
printf '%s' "Background Purple" | hooks_utility_colorful_print "\e[45m"
printf '\n'
printf '%s' "Background Cyan" | hooks_utility_colorful_print "\e[46m"
printf '\n'
printf '%s' "Background White" | hooks_utility_colorful_print "\e[47m"
printf '\n'

# High Intensity  --------------------------------------------------------------
echo "High Intensity" | hooks_utility_padding_centered "-"

printf '%s' "High Intensity Black" | hooks_utility_colorful_print "\e[0;90m"
printf '\n'
printf '%s' "High Intensity Red" | hooks_utility_colorful_print "\e[0;91m"
printf '\n'
printf '%s' "High Intensity Green" | hooks_utility_colorful_print "\e[0;92m"
printf '\n'
printf '%s' "High Intensity Yellow" | hooks_utility_colorful_print "\e[0;93m"
printf '\n'
printf '%s' "High Intensity Blue" | hooks_utility_colorful_print "\e[0;94m"
printf '\n'
printf '%s' "High Intensity Purple" | hooks_utility_colorful_print "\e[0;95m"
printf '\n'
printf '%s' "High Intensity Cyan" | hooks_utility_colorful_print "\e[0;96m"
printf '\n'
printf '%s' "High Intensity White" | hooks_utility_colorful_print "\e[0;97m"
printf '\n'

# Bold High Intensity  ---------------------------------------------------------
echo "Bold High Intensity" | hooks_utility_padding_centered "-"

printf '%s' "Bold High Intensity Black" |
    hooks_utility_colorful_print "\e[1;90m"
printf '\n'
printf '%s' "Bold High Intensity Red" |
    hooks_utility_colorful_print "\e[1;91m"
printf '\n'
printf '%s' "Bold High Intensity Green" |
    hooks_utility_colorful_print "\e[1;92m"
printf '\n'
printf '%s' "Bold High Intensity Yellow" |
    hooks_utility_colorful_print "\e[1;93m"
printf '\n'
printf '%s' "Bold High Intensity Blue" |
    hooks_utility_colorful_print "\e[1;94m"
printf '\n'
printf '%s' "Bold High Intensity Purple" |
    hooks_utility_colorful_print "\e[1;95m"
printf '\n'
printf '%s' "Bold High Intensity Cyan" |
    hooks_utility_colorful_print "\e[1;96m"
printf '\n'
printf '%s' "Bold High Intensity White" |
    hooks_utility_colorful_print "\e[1;97m"
printf '\n'

# High Intensity backgrounds  --------------------------------------------------
echo "High Intensity backgrounds" | hooks_utility_padding_centered "-"

printf '%s' "High Intensity backgrounds Black" |
    hooks_utility_colorful_print "\e[0;100m"
printf '\n'
printf '%s' "High Intensity backgrounds Red" |
    hooks_utility_colorful_print "\e[0;101m"
printf '\n'
printf '%s' "High Intensity backgrounds Green" |
    hooks_utility_colorful_print "\e[0;102m"
printf '\n'
printf '%s' "High Intensity backgrounds Yellow" |
    hooks_utility_colorful_print "\e[0;103m"
printf '\n'
printf '%s' "High Intensity backgrounds Blue" |
    hooks_utility_colorful_print "\e[0;104m"
printf '\n'
printf '%s' "High Intensity backgrounds Purple" |
    hooks_utility_colorful_print "\e[0;105m"
printf '\n'
printf '%s' "High Intensity backgrounds Cyan" |
    hooks_utility_colorful_print "\e[0;106m"
printf '\n'
printf '%s' "High Intensity backgrounds White" |
    hooks_utility_colorful_print "\e[0;107m"
printf '\n'
