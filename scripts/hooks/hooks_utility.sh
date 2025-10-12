#!/bin/bash

################################################################################
# hooks_utility.sh
# a collections of utility functions for git hooks
#
# author:  kamiLeL
# version: v1.0.1-alpha
################################################################################

# todo use a standard doc comment format


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

DATE_FORMAT="%Y-%m-%d"
TIME_FORMAT="%H:%M:%S"

# create standardized log messages
_print_log_message() { 
    # parse 2 starting position args
    local -i level="$1"
    local message="$2"
    shift 2

    # parse options
    local d_flag=0 t_flag=0

    local OPTIND opt OPTARG
    OPTIND=1
    while getopts ":dt" opt; do
        case "$opt" in
            d) d_flag=1;;
            t) t_flag=1;;
            \?) ;;  # ignore invalid options
        esac
    done

    # decide prefix tag & color based on level  --------------------------------
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

    # create date/time part  ---------------------------------------------------
    local timestamp=""

    local date_time_format=""
    if ((d_flag && t_flag)); then
        date_time_format="${DATE_FORMAT} ${TIME_FORMAT}"
    elif ((d_flag)); then
        date_time_format="${DATE_FORMAT}"
    elif ((t_flag)); then
        date_time_format="${TIME_FORMAT}"
    fi

    if [[ -n ${date_time_format} ]]; then
        printf -v timestamp "%([${date_time_format}] )T" -1
    fi

    # actually print  ----------------------------------------------------------
    local content="${timestamp}${prefix}:\t${message}"
    if [[ ${target_fd} == 1 ]]; then
        # print to stdout
        printf "%b\n" "$content"
    else
        # print to stderr
        printf "%b\n" "$content" >&2
    fi
}


# API log-style-message functions  =============================================

# hooks_utility_debug - print debug message 
# 
# usage: hooks_utility_debug MESSAGE [-d] [-t]
#
# print a MESSAGE prefixed with "DEBUG"
# 
# positional arguments:
#   MESSAGE     content of message to be printed
#
# options:
#   -d          prefix message with current date
#   -t          prefix message with current time
# 
# output:
#   print the given MESSAGE with log style formatting to stdout,
#   utilize ANSI coloring if stdout is a console
hooks_utility_debug() {
    _print_log_message 10 "$@"
}

# hooks_utility_info - print informational message 
# 
# usage: hooks_utility_info MESSAGE [-d] [-t]
#
# print a MESSAGE prefixed with "INFO" to stdout
# 
# positional arguments & options:
#   same as hooks_utility_debug()
#
# outputs:
#   same as hooks_utility_debug()
hooks_utility_info() {
    _print_log_message 20 "$@"
}

# hooks_utility_warning - print warning message 
# 
# usage: hooks_utility_warning MESSAGE [-d] [-t]
#
# print a MESSAGE prefixed with "INFO" to stdout
# 
# positional arguments & options:
#   same as hooks_utility_debug()
#
# outputs:
#   same as hooks_utility_debug()
hooks_utility_warning() {
    _print_log_message 30 "$@"
}

# hooks_utility_error - print error message 
# 
# usage: hooks_utility_error MESSAGE [-d] [-t]
#
# print a MESSAGE prefixed with "ERROR" to stderr/stdout
#
# positional arguments & options:
#   same as hooks_utility_debug()
# 
# output:
#   print the given MESSAGE with log style formatting to stdout/stderr
#   depending on configuration ENABLE_SPLIT_OUTPUT_STREAM;
#   utilize ANSI coloring if stdout is a console
hooks_utility_error() {
    _print_log_message 40 "$@"
}

# hooks_utility_critical - print critical error message 
# 
# usage: hooks_utility_critical MESSAGE [-d] [-t]
#
# print a MESSAGE prefixed with "CRIT" to stderr/stdout
#
# positional arguments & options:
#   same as hooks_utility_debug()
#
# outputs:
#   same as hooks_utility_error()
hooks_utility_critical() {
    _print_log_message 50 "$@"
}


# merging annotation markers check  ############################################
# Todo
# hooks_utility_merging_annotation_markers_check() {}
