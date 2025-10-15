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
# todo merge into dev, make sure CHANGELOG is edited


# configurations  ##############################################################

# filtering log messages:
# 10:debug & above, 20:information, 30:warning, 40:error, 50:critical
LOGGING_LEVEL=10
# use ANSI color codes when print to terminal by default
ENABLE_ANSI_COLOR=1
# messages, depending on their types, are sent to stdout & stderr respectively
ENABLE_SPLIT_OUTPUT_STREAM=1
# width of the imagined terminal
PADDING_TERMINAL_WIDTH=80


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


_print_log_message() {
    # filtering by log level
    local -i level="$1"; shift

    if [[ level -lt LOGGING_LEVEL  ]]; then
        # this message is filtered out
        return 0
    fi

    # consider configurations
    local target_fd=1 use_color=0
    (( ENABLE_SPLIT_OUTPUT_STREAM )) && [[ level -ge 40 ]]  && target_fd=2
    (( ENABLE_ANSI_COLOR )) && [[ -t "$target_fd" ]] && use_color=1

    # parse inputs  ------------------------------------------------------------
    local message
    message=$(cat -)  # read from stdin

    # parse options
    local -i d_flag=0 t_flag=0
    OPTIND=1
    while getopts ":dtcC" opt; do
        case "$opt" in
            d) d_flag=1 ;;
            t) t_flag=1 ;;
            c) use_color=1 ;;
            C) use_color=0 ;;
            \?) ;;  # ignore invalid options
        esac
    done
    shift $((OPTIND - 1))

    # parse args
    local source_arg="${1-}"

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
# print message from stdin in log style message, prefixed with "DEBUG"
#
# USAGE:
#   hooks_utility_debug [-d] [-t] [-c|-C] [SOURCE]
#
# ARGUMENT:
#   SOURCE      indicate reason/source of the message, as part of the message
#
# OPTION:
#   -d      contains current date
#   -t      contains current time
#   -c      always use ANSI coloring
#   -C      never use ANSI coloring
#
# OUTPUT:
#   print the formatted message to stdout;
#   utilizing ANSI coloring if stdout is a console
#
# RETURN:
#   0       success
#
# EXAMPLE:
#   echo "some debug information" | hooks_utility_debug
#   echo "some debug information" | hooks_utility_debug -dt  "Main Component"
hooks_utility_debug() {
    _print_log_message 10 "$@"
    return "$?"
}


# hooks_utility_info()
#
# print message from stdin in log style message, prefixed with "INFO"
#
# USAGE:
#   hooks_utility_info [-d] [-t] [-c|-C] [SOURCE]
#
# other aspects are same as hooks_utility_debug()
hooks_utility_info() {
    _print_log_message 20 "$@"
    return "$?"
}


# hooks_utility_warning()
#
# print message from stdin in log style message, prefixed with "WARN"
#
# USAGE:
#   hooks_utility_warning [-d] [-t] [-c|-C] [SOURCE]
#
# other aspects are same as hooks_utility_debug()
hooks_utility_warning() {
    _print_log_message 30 "$@"
    return "$?"
}


# hooks_utility_error()
#
# print message from stdin in log style message, prefixed with "ERROR"
#
# USAGE:
#   hooks_utility_error [-d] [-t] [-c|-C] [SOURCE]
#
# OUTPUT:
#   print the formatted message to stdout/stderr
#   depending on configuration ENABLE_SPLIT_OUTPUT_STREAM;
#   utilizing ANSI coloring if stdout/stderr is a console
#
# other aspects are same as hooks_utility_debug()
hooks_utility_error() {
    _print_log_message 40 "$@"
    return "$?"
}


# hooks_utility_critical()
#
# print message from stdin in log style message, prefixed with "CRIT"
#
# USAGE:
#   hooks_utility_critical [-d] [-t] [-c|-C] [SOURCE]
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
# FIXME change functions to pipe friendly, take stdin

# number of spaces surround the message text
PADDING_MARGIN=2
PADDING_PRINT_NAME="${HOOKS_UTILITY_NAME}:padding print"

# print space character,  as margin b/t padding & message to stdout
_print_padding_margin() {
    printf '%*s' "${PADDING_MARGIN}" ''
}


# print padding of the given count, to stdout
_print_padding_of_count() {
    local padding="$1"
    local -i cnt="$2" use_color="$3"

    # generating padding by cnt
    result=$( printf '%*s' "${cnt}" '' | tr ' ' "${padding}" )

    if (( use_color )); then
        result="${ANSI_COLOR_GREY}${result}${ANSI_RESET}"
    fi

    printf '%b' "${result}"
}


# main logic for padding print
_parse_adding_padding() {
    # parse inputs
    local -i type="$1"
    local padding="$2" message
    message=$(cat --)  # read from stdin

    local -i message_len  # calculate length of message
    message_len=$(printf '%s' "${message}" | wc -m)
    hooks_utility_debug "type=${type} message_len=${message_len}" \
            "${PADDING_PRINT_NAME}"

    # calculate left/right padding count  --------------------------------------
    local -i short_cnt long_cnt
    case "${type}" in
        0|1)
            # left & right just
            long_cnt=$((PADDING_TERMINAL_WIDTH - message_len - PADDING_MARGIN))
            short_cnt=1
            ;;
        2)
            # centered
            local remained=$((PADDING_TERMINAL_WIDTH \
                    - message_len - 2 * PADDING_MARGIN))
            short_cnt=$((remained / 2))
            long_cnt=$((remained - short_cnt))
            ;;
    esac

    hooks_utility_debug "short_cnt=${short_cnt} long_cnt=${long_cnt}" \
            "${PADDING_PRINT_NAME}"

    # generate actual printout  ------------------------------------------------
    # special case: message too long, just print message itself
    if [[ short_cnt -lt 1 || long_cnt -lt 1 ]]; then
        hooks_utility_debug "message too long"
        printf '%s\n' "${message}"
        return 0
    fi

    local use_color=0
    (( ENABLE_ANSI_COLOR )) && [[ -t 1 ]] && use_color=1

    case "${type}" in
        0)
            printf '%s' "${message}";
            _print_padding_margin;
            _print_padding_of_count "${padding}" "${long_cnt}" "${use_color}";
            ;;
        1)
            _print_padding_of_count "${padding}" "${long_cnt}" "${use_color}";
            _print_padding_margin;
            printf '%s' "${message}";
            ;;
        2)
            _print_padding_of_count "${padding}" "${short_cnt}" "${use_color}";
            _print_padding_margin;
            printf '%s' "${message}";
            _print_padding_margin;
            _print_padding_of_count "${padding}" "${long_cnt}" "${use_color}";
            ;;
    esac

    # TODO make optional
    # print newline ending
    printf '\n'
    return 0
}


# API padding print functions  =================================================

# TODO update doc comment
# hooks_utility_padding_left_just()
#
# print the MESSAGE with its right space filled with PADDING
#
# USAGE:
#   hooks_utility_padding_left_just PADDING MESSAGE
#
# ARGUMENT:
#   PADDING     single symbol padding, e.g. '='
#   MESSAGE     main message content to be printed
#
# OUTPUT:
#   print the MESSAGE with padding to stdout
#
# RETURN:
#   0       success
#
# EXAMPLE:
#   hooks_utility_padding_left_just '*' "Book Title"
hooks_utility_padding_left_just() {
    _parse_adding_padding 0 "$@"
    return "$?"
}


# hooks_utility_padding_right_just()
#
# print the MESSAGE with its left space filled with PADDING
#
# USAGE:
#   hooks_utility_padding_right_just PADDING MESSAGE
#
# other aspects are same as hooks_utility_padding_left_just()
hooks_utility_padding_right_just() {
    _parse_adding_padding 1 "$@"
    return "$?"
}


# hooks_utility_padding_centered()
#
# print the MESSAGE with its left and right space filled with PADDING
#
# USAGE:
#   hooks_utility_padding_centered PADDING MESSAGE
#
# other aspects are same as hooks_utility_padding_left_just()
hooks_utility_padding_centered() {
    _parse_adding_padding 2 "$@"
    return "$?"
}


# AM check  ####################################################################
# FIXME change functions to pipe friendly, take stdin

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

    local pattern
    case "${am_class}" in
        1)
            pattern="${PRIMARY_AM_PATTERN}"
             ;;
        2)
            pattern="${SECONDARY_AM_PATTERN}"
    esac

    # iterate each added & modified files
    while IFS= read -r -d '' file; do
        local lines
        lines=$(git diff --cached --unified=0 --no-color -- "${file}" \
                | grep '^+[^+]'\
                | cut -c2-\
                | grep -E "${pattern}" || true)

        if [[ -n ${lines} ]]; then
            printf "%s\n%s" "${file}" "${lines}" >> "${tmp_printout}"
        fi

    done < <(git diff --cached --name-only -z --diff-filter=ACMR)

}
