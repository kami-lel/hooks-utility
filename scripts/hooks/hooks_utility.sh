#!/bin/bash

################################################################################
# hooks_utility.sh
# a collections of utility functions for git hooks
#
# author:  kamiLeL
# version: v1.0.1-alpha
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
# all of length 5

ANSI_COLOR_BLUE='\e[0;34m'
ANSI_COLOR_YELLOW='\e[0;33m'
ANSI_COLOR_RED='\e[0;31m'
ANSI_RESET='\e[0m'

DATE_FORMAT="%Y-%m-%d"
TIME_FORMAT="%H:%M:%S"

# create standardized log messages
_print_log_message() {
    # parsing args & options
    local -i level="$1"; shift

    # parse options first
    local d_flag t_flag
    OPTIND=1
    while getopts ":dt" opt; do
        case "$opt" in
            d) d_flag=1 ;;
            t) t_flag=1 ;;
            \?) ;;  # ignore invalid options
        esac
    done
    shift $((OPTIND - 1))

    # parse args
    local message="$1"
    local source_arg="$2"

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
        date_time_format="[${DATE_FORMAT} ${TIME_FORMAT}]"
    elif ((d_flag)); then
        date_time_format="[${DATE_FORMAT}]"
    elif ((t_flag)); then
        date_time_format="[${TIME_FORMAT}]"
    fi

    if [[ -n ${date_time_format} ]]; then
        printf -v timestamp "%(${date_time_format})T" -1
    fi

    # create source part  ------------------------------------------------------
    local source=""
    if [[ -n ${source_arg} ]]; then
        source="(${source_arg})"
    fi

    # actually print  ----------------------------------------------------------
    local content="${timestamp}${prefix}${source}:\t${message}"
    if [[ ${target_fd} == 1 ]]; then
        # print to stdout
        printf "%b\n" "$content"
    else
        # print to stderr
        printf "%b\n" "$content" >&2
    fi
}


# API log style message functions  =============================================


# hooks_utility_debug()
#
# print a MESSAGE in log style message, prefixed with "DEBUG"
#
# USAGE:
#   hooks_utility_debug [-d] [-t] MESSAGE [SOURCE]
#
# ARGUMENT:
#   MESSAGE     main message content to be printed
#   SOURCE      indicate reason/source of the message, as part of the message
#
# OPTION:
#   -d      contains current date in the printed message
#   -t      contains current time in the printed message
#
# OUTPUT:
#   print the given MESSAGE, in log style formatting, to stdout;
#   utilizing ANSI coloring if stdout is a console
#
# RETURN:
#   0       success
#
# EXAMPLE:
#   hooks_utility_debug "some debug information"
#   hooks_utility_debug -dt "some debug information" "Main Component"
hooks_utility_debug() {
    _print_log_message 10 "$@"
    return "$?"
}


# hooks_utility_info()
#
# print a MESSAGE in log style message, prefixed with "INFO"
#
# USAGE:
#   hooks_utility_info [-d] [-t] MESSAGE [SOURCE]
#
# other aspects are same as hooks_utility_debug()
hooks_utility_info() {
    _print_log_message 20 "$@"
    return "$?"
}


# hooks_utility_warning()
#
# print a MESSAGE in log style message, prefixed with "WARN"
#
# USAGE:
#   hooks_utility_warning [-d] [-t] MESSAGE [SOURCE]
#
# other aspects are same as hooks_utility_debug()
hooks_utility_warning() {
    _print_log_message 30 "$@"
    return "$?"
}


# hooks_utility_error()
#
# print a MESSAGE in log style message, prefixed with "ERROR"
#
# USAGE:
#   hooks_utility_error [-d] [-t] MESSAGE [SOURCE]
#
# OUTPUT:
#   print the given MESSAGE, in log style formatting,
#   to stdout/stderr depending on configuration ENABLE_SPLIT_OUTPUT_STREAM,
#   utilizing ANSI coloring if stdout/stderr is a console
#
# other aspects are same as hooks_utility_debug()
hooks_utility_error() {
    _print_log_message 40 "$@"
    return "$?"
}


# hooks_utility_critical()
#
# print a MESSAGE in log style message, prefixed with "CRIT"
#
# USAGE:
#   hooks_utility_critical [-d] [-t] MESSAGE [SOURCE]
#
# OUTPUT:
#   same as hooks_utility_error()
#
# other aspects are same as hooks_utility_debug()
hooks_utility_critical() {
    _print_log_message 50 "$@"
    return "$?"
}


# merging annotation markers check  ############################################
# hooks_utility_merging_annotation_markers_check()
# TODO doc comment
hooks_utility_merging_annotation_markers_check() {
    # TODO
    local merge_type=""

    if [[ ${merge_type} == 'feature2dev' ]]; then
        _test_feature_merge_dev
    elif [[ ${merge_type} == 'dev2main' ]]; then
        _test_dev_merge_main
    fi

}

# AM checks when merging from feature branch to dev branch
_test_feature_merge_dev() {
    _assert_no_primary_am
}

# AM checks when merging from dev branch to main branch
_test_dev_merge_main() {
    _assert_no_primary_am
    _assert_no_secondary_am
}

# assert no TODO,BUG,FIXME,HACK occurs
_assert_no_primary_am() {
    :  # TODO
}

# assert no Todo,Bug,Fixme,Hack occurs
_assert_no_secondary_am() {
    :  # TODO
}