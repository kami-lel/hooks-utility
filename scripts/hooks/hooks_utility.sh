#!/bin/bash

set -euo pipefail

################################################################################
# hooks_utility.sh
# a collections of utility functions for git hooks
#
# author:  kamiLeL
# version: v1.0.1-alpha
################################################################################

# todo auto generate better commit/merge message
# TODO line padding print
# todo merge into dev, make sure CHANGELOG is edited


# configurations  ##############################################################

# filtering log messages:
# 10:debug & above, 20:information, 30:warning, 40:error, 50:critical
LOGGING_LEVEL=20
# use ANSI color codes when print to terminal
ENABLE_ANSI_COLOR=1
# messages, depending on their types, are sent to stdout & stderr respectively
ENABLE_SPLIT_OUTPUT_STREAM=1
# width of the imagined terminal
TERMINAL_MAX_WIDTH=80


# constants  ###################################################################

HOOKS_UTILITY_NAME="hooks_utility"

ANSI_COLOR_BLUE='\e[0;34m'
ANSI_COLOR_YELLOW='\e[0;33m'
ANSI_COLOR_RED='\e[0;31m'
ANSI_COLOR_GREY='\e[0;90m'
ANSI_RESET='\e[0m'


# log style message  ###########################################################

PREFIX_ERROR_DEBUG="DEBUG"
PREFIX_ERROR_INFO="INFO "
PREFIX_ERROR_WARNING="WARN "
PREFIX_ERROR_ERROR="ERROR"
PREFIX_ERROR_CRITICAL="CRIT "
# note: all of length 5

DATE_FORMAT="%Y-%m-%d"
TIME_FORMAT="%H:%M:%S"

# create standardized log messages
_print_log_message() {
    # filtering
    local -i level="$1"; shift

    if [[ level -lt LOGGING_LEVEL ]]; then
        # this message is filtered out
        return 0
    fi

    # parsing rest args & options  ---------------------------------------------

    # parse options first
    local d_flag="" t_flag=""
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
    local source_arg="${2-}"

    # consider configurations  -------------------------------------------------
    local target_fd=1 use_color=0
    (( ENABLE_SPLIT_OUTPUT_STREAM )) && [[ level -ge 40 ]]  && target_fd=2
    (( ENABLE_ANSI_COLOR )) && [[ -t "$target_fd" ]] && use_color=1

    # decide prefix tag & color based on level  --------------------------------
    local prefix prefix_color
    case "$level" in
    10)  # debug
        prefix_tag="$PREFIX_ERROR_DEBUG"
        prefix_color="$ANSI_COLOR_BLUE"
        ;;
    20)  # info
        prefix_tag="$PREFIX_ERROR_INFO"
        prefix_color="$ANSI_COLOR_YELLOW"
        ;;
    30)  # warning
        prefix_tag="$PREFIX_ERROR_WARNING"
        prefix_color="$ANSI_COLOR_YELLOW"
        ;;
    40)  # error
        prefix_tag="$PREFIX_ERROR_ERROR"
        prefix_color="$ANSI_COLOR_RED"
        ;;
    50)  # critical
        prefix_tag="$PREFIX_ERROR_CRITICAL"
        prefix_color="$ANSI_COLOR_RED"
        ;;
    esac

    # create prefix part w/ coloring
    if (( use_color )); then
        prefix="${prefix_color}${prefix_tag}${ANSI_RESET}"
    else
        prefix="${prefix_tag}"
    fi

    # create date/time part  ---------------------------------------------------
    local timestamp=""

    local date_time_format=""
    if ((d_flag && t_flag)); then
        date_time_format="${DATE_FORMAT} ${TIME_FORMAT} "
    elif ((d_flag)); then
        date_time_format="${DATE_FORMAT} "
    elif ((t_flag)); then
        date_time_format="${TIME_FORMAT} "
    fi

    # create date/time part w/ coloring
    if (( use_color )); then
        date_time_format="${ANSI_COLOR_GREY}${date_time_format}${ANSI_RESET}"
    fi

    # populate format w/ current time
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


# padding print  ###############################################################
# TODO


_print_with_padding() {
    local -i type="$1"
    local padding="$2" message="$3"
}

hooks_utility_padding_left_just() {
    _print_with_padding 0 "$@"
    return "$?"
}

hooks_utility_padding_right_just() {
    _print_with_padding 1 "$@"
    return "$?"
}

hooks_utility_padding_centered() {
    _print_with_padding 2 "$@"
    return "$?"
}

# AM check  ####################################################################

DEV_BRANCH_NAME='dev'
MAIN_BRANCH_NAME='main'
AM_CHECK_NAME="${HOOKS_UTILITY_NAME}:AM check"
PRIMARY_AM_PATTERN='TODO|BUG|FIXME|HACK'
SECONDARY_AM_PATTERN='Todo|Bug|Fixme|Hack'


# hooks_utility_am_check()
#
# assert there is NO annotation markers (AM) merging into protected branches,
# (i.e. 'dev' and 'main' branches.)
#
# - any branch (except main) -> dev:
#   assert no primary AM (TODO, BUG, ...) is merging into dev branch
#
# - dev -> main:
#   assert no primary nor secondary AM (TODO, BUG, ..., Todo, Bug, ...)
#   is merging into main branch
#
# USAGE:
#   hooks_utility_am_check
#
# RETURN:
#   0   success: pass or skip checks
#   1   failure: undesired AM detected
hooks_utility_am_check() {
    hooks_utility_debug "start" "${AM_CHECK_NAME}"

    local -r merge_head_dir="$(git rev-parse --git-dir)/MERGE_HEAD"

    # skip non-merge commit
    if ! [[ -f "${merge_head_dir}" ]]; then
        hooks_utility_info \
                "skipped, not a merge commit" "${AM_CHECK_NAME}"
        return 0
    elif [[ $(wc -l < "${merge_head_dir}") -ne 1 ]]; then
        hooks_utility_info \
                "skipped, octopus merge" "${AM_CHECK_NAME}"
        return 0
    fi


    # find merge type  =========================================================
    local -i merge_type

    # find source_branch, i.e. branch which merge from
    local source_sha source_branch
    source_sha=$(cat "${merge_head_dir}")
    source_branch=$(git name-rev --name-only "${source_sha}")

    # find target_branch, i.e. branch which merge into
    local target_branch
    target_branch=$(git rev-parse --abbrev-ref HEAD)

    hooks_utility_debug \
            "source_branch=${source_branch}; target_branch=${target_branch}" \
            "${AM_CHECK_NAME}"

    # decide merge type  -------------------------------------------------------
    if [[ "${source_branch}" != "${MAIN_BRANCH_NAME}" && \
            "${target_branch}" == "${DEV_BRANCH_NAME}" ]]; then
        merge_type=1  # from feature branches -> dev branch

    elif [[ "${source_branch}" == "${DEV_BRANCH_NAME}" && \
            "${target_branch}" == "${MAIN_BRANCH_NAME}" ]]; then
        merge_type=2  # from dev branch -> main branch

    else
        hooks_utility_info "skipped, irrelevant merge" \
                "${AM_CHECK_NAME}"
        return 0
    fi

    hooks_utility_debug "merge_type=${merge_type}" "${AM_CHECK_NAME}"

    # search AM in incoming content  ===========================================
    local tmp_printout
    tmp_printout=$(mktemp)

    case "${merge_type}" in
        1)  # feature -> dev
            _search_am_generate_printout 1 "${tmp_printout}"
            ;;
        2)  # dev -> main
            _search_am_generate_printout 1 "${tmp_printout}"
            _search_am_generate_printout 2 "${tmp_printout}"
            ;;
    esac

    if [[ -s "${tmp_printout}" ]]; then
        local printout_content
        printout_content=$(cat "${tmp_printout}")
        hooks_utility_error "found undesired AM(s) in incoming content:\n\
${printout_content}" \
                "${AM_CHECK_NAME}"
        return 1
    else
        hooks_utility_info "passed" "${AM_CHECK_NAME}"
        return 0
    fi
}


_search_am_generate_printout() {
    local -i am_class="$1"  # 1:primary AM, 2:secondary AM
    local tmp_printout="$2"

    local pattern class_name
    case "${am_class}" in
        1)
            pattern="${PRIMARY_AM_PATTERN}"
            class_name='primary AM'
             ;;
        2)
            pattern="${SECONDARY_AM_PATTERN}"
            class_name='secondary AM';;
    esac

    # print class name
    # FIXME use padding
    printf "found %s:\n" "${class_name}" >> "${tmp_printout}"

    # iterate each added & modified files
    while IFS= read -r -d '' file; do
        local lines
        lines=$(git diff --cached --unified=0 --no-color -- "${file}" \
                | grep '^+[^+]'\
                | cut -c2-\
                | grep -E "${pattern}" || true)

        # Bug sometimes still prevent merge
        if [[ -n ${lines} ]]; then
            # FIXME use padding
            printf "%s\n%s" "${file}" "${lines}" >> "${tmp_printout}"
        fi

    done < <(git diff --cached --name-only -z --diff-filter=ACMR)

}
