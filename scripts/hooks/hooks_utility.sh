#!/bin/bash

################################################################################
# hooks_utility.sh
# a collections of utility functions for git hooks
#
# author:  kamiLeL
# version: v1.0.0
################################################################################


# configurations
# use ANSI color codes when print to terminal
ENABLE_ANSI_COLOR=1
# messages, depending on their types, are sent to stdout & stderr respectively
ENABLE_SPLIT_OUTPUT_STREAM=1


# log style message  ###########################################################
PREFIX_ERROR_DEBUG="DEBUG"
PREFIX_ERROR_INFO="INFO "
PREFIX_ERROR_WARNING="WARN "
PREFIX_ERROR_ERROR="ERROR"
PREFIX_ERROR_CRITICAL="CRIT "

ANSI_COLOR_BLUE='\e[0;34m'
ANSI_COLOR_YELLOW='\e[0;33m'
ANSI_COLOR_RED='\e[0;31m'
ANSI_RESET='\e[0m'

# _print_log_message - create standardized log messages  -----------------------
# TODO write comments
# Arguments:
#   message     message content (String)
#   level        integer
_print_log_message() { 
    # TODO date/time
    local -i level="$1"
    local message="$2"

    # decide prefix tag & color based on level
    local prefix ansi_color
    case "$level" in
    10)  # debug
        prefix_tag="$PREFIX_ERROR_DEBUG"
        ansi_color="$ANSI_COLOR_BLUE"
        ;;
    20)  # info
        prefix_tag="$PREFIX_ERROR_INFO"
        ansi_color="$ANSI_COLOR_YELLOW"
        ;;
    30)  # warning
        prefix_tag="$PREFIX_ERROR_WARNING"
        ansi_color="$ANSI_COLOR_YELLOW"
        ;;
    40)  # error
        prefix_tag="$PREFIX_ERROR_ERROR"
        ansi_color="$ANSI_COLOR_RED"
        ;;
    50)  # critical
        prefix_tag="$PREFIX_ERROR_CRITICAL"
        ansi_color="$ANSI_COLOR_RED"
        ;;
    esac

    # create prefix part w/ coloring
    local target_fd=$((ENABLE_SPLIT_OUTPUT_STREAM && level >= 40 ?\
            2 : 1))
    if (( "${ENABLE_ANSI_COLOR}" )) && [[ -t "${target_fd}" ]]; then
        prefix="${ansi_color}${prefix_tag}${ANSI_RESET}"
    else
        prefix="${prefix_tag}"
    fi

    # actually print
    local content="${prefix}:\t${message}"
    if [[ ${target_fd} == 1 ]]; then
        # print to stdout
        printf "%b\n" "$content"
    else
        # print to stderr
        printf "%b\n" "$content" >&2
    fi
}


# TODO write comments for each
# hooks_utility_debug - print debug message  -----------------------------------
hooks_utility_debug() {
    _print_log_message 10 "$1"
}

hooks_utility_info() {
    _print_log_message 20 "$1"
}

hooks_utility_warning() {
    _print_log_message 30 "$1"
}

hooks_utility_error() {
    _print_log_message 40 "$1"
}

hooks_utility_critical() {
    _print_log_message 50 "$1"
}




# search annotation markers  ###################################################

# todo
# hooks_utility_pre_merge_test_annotation_markers() {}
