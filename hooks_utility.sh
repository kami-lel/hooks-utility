#!/bin/bash

set -euo pipefail

################################################################################
# hooks_utility.sh
# a collections of utility functions for git hooks
#
# author:  kamiLeL
# version: v1.1.1
################################################################################

# configurations  ##############################################################

# use ANSI color code when print to terminal
ENABLE_ANSI_COLOR="${ENABLE_ANSI_COLOR:-1}"
# 1=enable, 0=disable

# max width (number of columns) of terminal
PADDING_TERMINAL_WIDTH="${PADDING_TERMINAL_WIDTH:-80}"

# log style message config  ----------------------------------------------------
# filtering level
LOGGING_LEVEL="${LOGGING_LEVEL:-20}"
# 10:debug & above, 20:information, 30:warning, 40:error, 50:critical

# sent messages to stdout/stderr depending on message level
ENABLE_SPLIT_OUTPUT_STREAM="${ENABLE_SPLIT_OUTPUT_STREAM:-1}"
# 1=message of level >= 30 is sent to stderr, while rest is sent to stdout
# 0=all messages are sent to stdout

# branch protection config  ----------------------------------------------------
MAIN_BRANCH_NAME="${MAIN_BRANCH_NAME:-main}"
DEV_BRANCH_NAME="${DEV_BRANCH_NAME:-dev}"

# global constants  ############################################################
HOOKS_UTILITY_DISPLAY_NAME="HU"

# ANSI colorful print  #########################################################

# generic print colorful function  =============================================
# hooks_utility_colorful_print()
#
# print message from stdin utilizing ANSI color escape code
#
# USAGE:
#   hooks_utility_colorful_print [-c|-C] COLOR
#
# ARGUMENT:
#   COLOR       ANSI color escape code, e.g. '\e[0;31m' for red
#
# OPTION:
#   -c      always use ANSI coloring
#   -C      never use ANSI coloring
#
# OUTPUT:
#   print MESSAGE in COLOR to stdout
#
# RETURN:
#   0       success
#
# EXAMPLE:
#   echo "content in red" | hooks_utility_colorful_print "\e[0;31m"
hooks_utility_colorful_print() {
    # BUG stdout/stderr confused
    # parse opn  ---------------------------------------------------------------
    local -i lc_c_flag=0 uc_c_flag=0
    OPTIND=1
    while getopts ":cC" opt; do
        case "$opt" in
        c) lc_c_flag=1 ;;
        C) uc_c_flag=1 ;;
        \?) ;; # ignore invalid options
        esac
    done
    shift $((OPTIND - 1))

    # perform by calling internal  ---------------------------------------------
    _colorful_print_with_target_fd "${1}" 1 "${lc_c_flag}" "${uc_c_flag}"
    return "$?"
}

# colorful print of specific color  ============================================
# hooks_utility_print_in_black()
# hooks_utility_print_in_red()
# hooks_utility_print_in_green()
# hooks_utility_print_in_yellow()
# hooks_utility_print_in_blue()
# hooks_utility_print_in_purple()
# hooks_utility_print_in_cyan()
# hooks_utility_print_in_white()
#
# print MESSAGE in a color utilizing ANSI color escape code,
# q.v. hooks_utility_colorful_print()
#
# USAGE:
#   hooks_utility_print_in_* MESSAGE
#
# ARGUMENT:
#   MESSAGE     content to be print
#
# OUTPUT:
#   print MESSAGE in COLOR to stdout
#
# RETURN:
#   0       success
#
# EXAMPLE:
#   echo "content in red" | hooks_utility_print_in_red
hooks_utility_print_in_black() {
    hooks_utility_colorful_print "${ANSI_COLOR_BLACK}"
}

hooks_utility_print_in_red() {
    hooks_utility_colorful_print "${ANSI_COLOR_RED}"
}

hooks_utility_print_in_green() {
    hooks_utility_colorful_print "${ANSI_COLOR_GREEN}"
}

hooks_utility_print_in_yellow() {
    hooks_utility_colorful_print "${ANSI_COLOR_YELLOW}"
}

hooks_utility_print_in_blue() {
    hooks_utility_colorful_print "${ANSI_COLOR_BLUE}"
}

hooks_utility_print_in_purple() {
    hooks_utility_colorful_print "${ANSI_COLOR_PURPLE}"
}

hooks_utility_print_in_cyan() {
    hooks_utility_colorful_print "${ANSI_COLOR_CYAN}"
}

hooks_utility_print_in_white() {
    hooks_utility_colorful_print "${ANSI_COLOR_WHITE}"
}

# constants  ===================================================================
ANSI_COLOR_BLACK='\e[0;30m'
ANSI_COLOR_RED='\e[0;31m'
ANSI_COLOR_RED_BOLD='\e[1;31m'
ANSI_COLOR_RED_BG='\e[41m'
ANSI_COLOR_GREEN='\e[0;32m'
ANSI_COLOR_GREEN_BOLD='\e[1;32m'
ANSI_COLOR_GREEN_BG='\e[42m'
ANSI_COLOR_YELLOW='\e[0;33m'
ANSI_COLOR_YELLOW_BG='\e[43m'
ANSI_COLOR_BLUE='\e[0;34m'
ANSI_COLOR_BLUE_BOLD='\e[1;34m'
ANSI_COLOR_BLUE_BG='\e[44m'
ANSI_COLOR_PURPLE='\e[0;35m'
ANSI_COLOR_CYAN='\e[0;36m'
ANSI_COLOR_WHITE='\e[0;37m'
ANSI_RESET='\e[0m'

# helper methods  ==============================================================
_colorful_print_with_target_fd() {
    local color
    local -i target_fd lc_c_flag uc_c_flag
    color="${1}"
    target_fd="${2}"
    lc_c_flag="${3}"
    uc_c_flag="${4}"

    # decide color by config  --------------------------------------------------
    local use_color=0
    ((ENABLE_ANSI_COLOR)) && [[ -t "$target_fd" ]] && use_color=1
    if ((lc_c_flag)); then
        use_color=1
    elif ((uc_c_flag)); then
        use_color=0
    fi

    message=$(cat -) # read from stdin

    # actually print  ---------------------------------------------------------
    local content
    # decide if coloring
    if ((use_color)); then
        content="${color}${message}${ANSI_RESET}"
    else
        content="${message}"
    fi

    # decide stdout or stderr
    if [[ ${target_fd} == 1 ]]; then
        # print to stdout
        printf "%b" "$content"
    else
        # print to stderr
        printf "%b" "$content" >&2
    fi

    return 0
}

# log style message  ###########################################################

# hooks_utility_debug()
# hooks_utility_enter()
# hooks_utility_info()
# hooks_utility_pass()
# hooks_utility_warning()
# hooks_utility_error()
# hooks_utility_fail()
# hooks_utility_critical()
#
# print message from stdin in log style message, prefixed with:
#
# - "DEBUG" or "ENTER"
# - "INFO " or "PASS "
# - "WARN "
# - "ERROR" or "FAIL "
# - "CRIT "
#
# USAGE:
#   hooks_utility_* [-d] [-t] [-c|-C] [SOURCE]
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

hooks_utility_enter() {
    _print_log_message 11 "$@"
    return "$?"
}

hooks_utility_info() {
    _print_log_message 20 "$@"
    return "$?"
}

hooks_utility_warning() {
    _print_log_message 30 "$@"
    return "$?"
}

hooks_utility_error() {
    _print_log_message 40 "$@"
    return "$?"
}

hooks_utility_critical() {
    _print_log_message 50 "$@"
    return "$?"
}

hooks_utility_pass() {
    _print_log_message 21 "$@"
    return "$?"
}

hooks_utility_fail() {
    _print_log_message 41 "$@"
    return "$?"
}

# constants  ===================================================================
# note: all of length 5
PREFIX_ERROR_DEBUG="DEBUG"
PREFIX_ERROR_INFO="INFO "
PREFIX_ERROR_WARNING="WARN "
PREFIX_ERROR_ERROR="ERROR"
PREFIX_ERROR_CRITICAL="CRIT "
PREFIX_ERROR_ENTER="ENTER"
PREFIX_ERROR_PASS="PASS "
PREFIX_ERROR_FAIL="FAIL "

DATE_FORMAT="%Y-%m-%d"
TIME_FORMAT="%H:%M:%S"

# helper functions  ============================================================
_print_log_message() {
    local -i level="$1"
    shift

    # filtering (skip) by log level
    if [[ level -lt LOGGING_LEVEL ]]; then
        # this message is filtered out
        return 0
    fi

    # parse inputs  ------------------------------------------------------------
    # consider configurations
    local target_fd=1
    ((ENABLE_SPLIT_OUTPUT_STREAM)) && [[ level -ge 40 ]] && target_fd=2

    local message_arg
    message_arg=$(cat -) # read from stdin

    # parse opn
    local -i d_flag=0 t_flag=0 lc_c_flag=0 uc_c_flag=0
    OPTIND=1
    while getopts ":dtcC" opt; do
        case "$opt" in
        d) d_flag=1 ;;
        t) t_flag=1 ;;
        c) lc_c_flag=1 ;;
        C) uc_c_flag=1 ;;
        \?) ;; # ignore invalid options
        esac
    done
    shift $((OPTIND - 1))

    # parse args
    local source_arg="${1-}"

    # print date/time part  ---------------------------------------------------
    local date_time_format=""
    if ((d_flag && t_flag)); then
        date_time_format="${DATE_FORMAT} ${TIME_FORMAT} "
    elif ((d_flag)); then
        date_time_format="${DATE_FORMAT} "
    elif ((t_flag)); then
        date_time_format="${TIME_FORMAT} "
    fi

    if [[ -n ${date_time_format} ]]; then # print only needed
        printf "%(${date_time_format})T" -1 |
            _colorful_print_with_target_fd \
                "${ANSI_COLOR_BLACK}" "${target_fd}" \
                "${lc_c_flag}" "${uc_c_flag}"
    fi

    # print prefix part  -------------------------------------------------------
    local prefix_color
    case "$level" in
    10) # debug
        prefix_tag="$PREFIX_ERROR_DEBUG"
        prefix_color="$ANSI_COLOR_BLUE"
        ;;
    11) # enter
        prefix_tag="$PREFIX_ERROR_ENTER"
        prefix_color="$ANSI_COLOR_BLUE_BOLD"
        ;;
    20) # info
        prefix_tag="$PREFIX_ERROR_INFO"
        prefix_color="$ANSI_COLOR_YELLOW"
        ;;
    21) # pass
        prefix_tag="$PREFIX_ERROR_PASS"
        prefix_color="$ANSI_COLOR_GREEN_BOLD"
        ;;
    30) # warning
        prefix_tag="$PREFIX_ERROR_WARNING"
        prefix_color="$ANSI_COLOR_YELLOW"
        ;;
    40) # error
        prefix_tag="$PREFIX_ERROR_ERROR"
        prefix_color="$ANSI_COLOR_RED"
        ;;
    41) # fail
        prefix_tag="$PREFIX_ERROR_FAIL"
        prefix_color="$ANSI_COLOR_RED_BOLD"
        ;;
    50) # critical
        prefix_tag="$PREFIX_ERROR_CRITICAL"
        prefix_color="$ANSI_COLOR_RED"
        ;;
    esac

    printf '%s' "${prefix_tag}" |
        _colorful_print_with_target_fd \
            "${prefix_color}" "${target_fd}" \
            "${lc_c_flag}" "${uc_c_flag}"

    # create source part  ------------------------------------------------------
    local source=""
    if [[ -n ${source_arg} ]]; then
        source="(${source_arg})"
    fi

    # create message part  -----------------------------------------------------
    local message=""
    if [[ -n ${message_arg} ]]; then
        message=":\t${message_arg}"
    fi

    # print source & message part
    if [[ ${target_fd} == 1 ]]; then
        # print to stdout
        printf "%b%b\n" "${source}" "${message}"
    else
        # print to stderr
        printf "%b%b\n" "${source}" "${message}" >&2
    fi

    return 0
}

# padding print  ###############################################################

# hooks_utility_padding_left_just()
#
# print the message from stdin with its right space filled with PADDING
#
# USAGE:
#   hooks_utility_padding_left_just [-c|-C] [-N] PADDING
#
# ARGUMENT:
#   PADDING     single symbol padding, e.g. '='
#
# OPTION:
#   -c      always use ANSI coloring
#   -C      never use ANSI coloring
#   -N      no add newline at the end
#
# OUTPUT:
#   print the message with padding to stdout
#
# RETURN:
#   0       success
#
# EXAMPLE:
#   echo "Book Title" | hooks_utility_padding_left_just '*'
hooks_utility_padding_left_just() {
    _parse_adding_padding 0 "$@"
    return "$?"
}

# hooks_utility_padding_right_just()
#
# print the message from stdin with its left space filled with PADDING
#
# USAGE:
#   hooks_utility_padding_right_just [-c|-C] [-N] PADDING
#
# other aspects are same as hooks_utility_padding_left_just()
hooks_utility_padding_right_just() {
    _parse_adding_padding 1 "$@"
    return "$?"
}

# hooks_utility_padding_centered()
#
# print the message from stdin with its left and right space filled with PADDING
#
# USAGE:
#   hooks_utility_padding_centered [-c|-C] [-N] PADDING
#
# other aspects are same as hooks_utility_padding_left_just()
hooks_utility_padding_centered() {
    _parse_adding_padding 2 "$@"
    return "$?"
}

# constants  ===================================================================
PADDING_MARGIN=2 # number of spaces surround the message text

# helper functions  ============================================================
# print space character,  as margin b/t padding & message to stdout
_print_padding_margin() {
    printf '%*s' "${PADDING_MARGIN}" ''
}

# print padding of the given count, to stdout
_print_padding_of_count() {
    local padding="${1}"
    local -i cnt="${2}" lc_c_flag="${3}" uc_c_flag="${4}"

    # generating padding by cnt
    result=$(printf '%*s' "${cnt}" '' | tr ' ' "${padding}")

    printf '%s' "${result}" |
        _colorful_print_with_target_fd \
            "${ANSI_COLOR_BLACK}" 1 "${lc_c_flag}" "${uc_c_flag}"
}

# main logic for padding print
_parse_adding_padding() {
    local -i type="$1"
    shift

    # parse inputs  ------------------------------------------------------------
    local message
    message=$(cat --) # read from stdin

    local -i nn_flag=0 lc_c_flag=0 uc_c_flag=0
    # parse options
    OPTIND=1
    while getopts ":cCN" opt; do
        case "$opt" in
        c) lc_c_flag=1 ;;
        C) uc_c_flag=1 ;;
        N) nn_flag=1 ;;
        \?) ;; # ignore invalid options
        esac
    done
    shift $((OPTIND - 1))

    # parse args
    local padding="${1}"

    local -i message_len # calculate length of message
    message_len=$(printf '%s' "${message}" | wc -m)

    # calculate left/right padding count  --------------------------------------
    local -i short_cnt long_cnt
    case "${type}" in
    0 | 1)
        # left & right just
        long_cnt=$((PADDING_TERMINAL_WIDTH - message_len - PADDING_MARGIN))
        short_cnt=1
        ;;
    2)
        # centered
        local remained=$((PADDING_TERMINAL_WIDTH - \
            message_len - 2 * PADDING_MARGIN))
        short_cnt=$((remained / 2))
        long_cnt=$((remained - short_cnt))
        ;;
    esac

    # print out  ---------------------------------------------------------------
    # special case: message too long, just print message itself
    if [[ short_cnt -lt 1 || long_cnt -lt 1 ]]; then
        printf '%s\n' "${message}"
    else

        # generate actual printout
        case "${type}" in
        0)
            printf '%s' "${message}"
            _print_padding_margin
            _print_padding_of_count \
                "${padding}" "${long_cnt}" "${lc_c_flag}" "${uc_c_flag}"
            ;;
        1)
            _print_padding_of_count \
                "${padding}" "${long_cnt}" "${lc_c_flag}" "${uc_c_flag}"
            _print_padding_margin
            printf '%s' "${message}"
            ;;
        2)
            _print_padding_of_count \
                "${padding}" "${short_cnt}" "${lc_c_flag}" "${uc_c_flag}"
            _print_padding_margin
            printf '%s' "${message}"
            _print_padding_margin
            _print_padding_of_count \
                "${padding}" "${long_cnt}" "${lc_c_flag}" "${uc_c_flag}"
            ;;
        esac
    fi

    if ! ((nn_flag)); then
        printf '\n'
    fi

    return 0
}

# branch protection  ###########################################################
# abbr. BP

# hooks_utility_protect_branch()
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
#   hooks_utility_protect_branch
#
# RETURN:
#   0   success: pass or skip checks
#   1   failure: undesired AM detected
hooks_utility_protect_branch() {
    echo "${BP_DISPLAY_NAME}" | hooks_utility_enter ''

    local commit_type
    commit_type=$(get_commit_type_at_pre_commit)
    printf 'commit_type=%s' "${commit_type}" |
        hooks_utility_debug "${BP_DISPLAY_NAME}"

    local result=""
    # populate result
    case "${commit_type}" in
    merge-binary-finish_feature)
        result=$(_search_am_from_git_diff_cached 1)
        ;;
    merge-binary-release)
        result1="$(_search_am_from_git_diff_cached 1)"
        result2="$(_search_am_from_git_diff_cached 2)"
        if [[ -n $result1 || -n $result2 ]]; then
            result="${result1}"$'\n'"${result2}"
        else
            result=""
        fi
        ;;
    *)
        echo "skipped, trivial commit type" |
            hooks_utility_debug "${BP_DISPLAY_NAME}"
        return 0
        ;;
    esac

    # decide whether check is passed
    if [[ -n "${result}" ]]; then
        printf 'remove AM(s) of incoming branch in file(s):\n%s' "${result}" |
            hooks_utility_fail "${BP_DISPLAY_NAME}"
        return 1
    else
        echo "${BP_DISPLAY_NAME}" | hooks_utility_pass ''
        return 0
    fi
}

# constants  ===================================================================
BP_DISPLAY_NAME='branch protection'

PRIMARY_AM_PATTERN='TODO|BUG|FIXME|HACK'
SECONDARY_AM_PATTERN='Todo|Bug|Fixme|Hack'
TERTIARY_AM_PATTERN='todo|bug|fixme|hack'
AM_TYPE_TODO='todo'
AM_TYPE_BUG='bug'
AM_TYPE_FIXME='fixme'
AM_TYPE_HACK='hack'

# helper functions  ============================================================

# get_commit_type_at_pre_commit()
#
# in pre-commit, decide type of the commit
#
# OUTPUT:
#   commit type printed to stdout:
#
#   - 'normal': regular commit, and other non-merge commit
#   - 'merge-binary': binary merge commit of 2 branches
#
#       - 'merge-binary-finish_feature': any branch (except main) -> dev branch
#       - 'merge-binary-release': dev branch -> main branch
#
#   - 'merge-octopus': octopus merge commit of 3+ branches
#
# EXAMPLE:
#   if [[ $( get_commit_type_at_pre_commit ) == "merge-binary" ]]
get_commit_type_at_pre_commit() {
    local -r merge_head_dir="$(git rev-parse --git-dir)/MERGE_HEAD"

    if ! [[ -f "${merge_head_dir}" ]]; then
        # regular commit  ------------------------------------------------------
        # include other non-merge commit types
        printf ''
    elif [[ $(wc -l <"${merge_head_dir}") -ne 1 ]]; then
        # octopus merge  -------------------------------------------------------
        printf 'merge-octopus'

    else
        # binary merge  --------------------------------------------------------

        # find source_branch, i.e. branch which merge from
        local source_sha source_branch
        source_sha=$(cat "${merge_head_dir}")
        source_branch=$(git name-rev --name-only "${source_sha}")

        # find target_branch, i.e. branch which merge into
        local target_branch
        target_branch=$(git rev-parse --abbrev-ref HEAD)

        # decide merge type
        if [[ "${source_branch}" != "${MAIN_BRANCH_NAME}" &&
            "${target_branch}" == "${DEV_BRANCH_NAME}" ]]; then
            printf 'merge-binary-finish_feature'

        elif [[ "${source_branch}" == "${DEV_BRANCH_NAME}" &&
            "${target_branch}" == "${MAIN_BRANCH_NAME}" ]]; then
            printf 'merge-binary-release'
        else
            printf 'merge-binary'
        fi
    fi

    return 0
}

# perform git diff --cached, find all AMs, print to stdout
_search_am_from_git_diff_cached() {
    local -i am_class="$1" # 1:primary AM, 2:secondary, 3: tertiary

    # decide which pattern to use
    local pattern
    pattern="$(_am_class_index2pattern "${am_class}")"

    # iterate each added & modified files
    while IFS= read -r -d '' filename; do
        local lines
        lines=$(git diff --cached --unified=0 --no-color -- "${filename}" |
            grep '^+[^+]' |
            cut -c2- | grep -E "${pattern}" || true)

        if [[ -n ${lines} ]]; then
            # print file name
            printf '%s' "${filename}" | hooks_utility_padding_centered -c '-'

            # print lines with AMs
            while IFS= read -r line || [ -n "$line" ]; do
                _highlight_am_line_in_git_diff_cached "${line}" "${pattern}"
            done <<<"$lines"

        fi
    done < <(git diff --cached --name-only -z --diff-filter=ACMR)
}

# convert AM class index [1~3] to pattern
_am_class_index2pattern() {
    local am_class="${1}"

    case "${am_class}" in
    1) echo "${PRIMARY_AM_PATTERN}" ;;
    2) echo "${SECONDARY_AM_PATTERN}" ;;
    3) echo "${TERTIARY_AM_PATTERN}" ;;
    esac
}

_highlight_am_line_in_git_diff_cached() {
    local line pattern split_pattern
    line="${1}"
    pattern="${2}"

    split_pattern="^(.*)(${pattern})(.*)$"

    if [[ $line =~ $split_pattern ]]; then
        printf '%s' "${BASH_REMATCH[1]}"
        _highlight_am_by_types "${BASH_REMATCH[2]}"
        printf '%s\n' "${BASH_REMATCH[3]}"
    else
        printf '%s\n' "${line}" # fallback
    fi
}

# add coloring of AM based on types
_highlight_am_by_types() {
    local am am_lc color
    am="${1}"
    am_lc="${am,,}" # make lower case

    case "${am_lc}" in
    "${AM_TYPE_TODO}") color="${ANSI_COLOR_GREEN_BG}" ;;
    "${AM_TYPE_BUG}") color="${ANSI_COLOR_RED_BG}" ;;
    "${AM_TYPE_FIXME}") color="${ANSI_COLOR_YELLOW_BG}" ;;
    "${AM_TYPE_HACK}") color="${ANSI_COLOR_BLUE_BG}" ;;
    esac

    printf '%s' "${am}" | hooks_utility_colorful_print -c "${color}"
}

# ensure file modification  ####################################################
#
# abbr. EFM

# hooks_utility_ensure_file_modification()
#
# in pre-commit, ensure certain file(s) must be modified
#
# USAGE:
#   hooks_utility_ensure_file_modification FILE COMMIT_TYPE MESSAGE
#
# ARGUMENT:
#   FILE            file which is required to be changed,
#                   relative path to repo root
#   COMMIT_TYPE     when to perform check, q.v. get_commit_type_at_pre_commit()
#   MESSAGE         reason of failing this test
#
# RETURN:
#   0       success, FILE is edited; or skip b/c irrelevant COMMIT_TYPE
#   1       failure, FILE hasn't been edited
#
# EXAMPLE:
#   hooks_utility_ensure_file_modification 'CHANGELOG.md' \
#           'merge-binary-finish_feature' \
#           'must record CHANGELOG when finish a feature branch' \
hooks_utility_ensure_file_modification() {
    local filename commit_type_arg message
    filename="$1"
    commit_type_arg="$2"
    message="$3"

    commit_type=$(get_commit_type_at_pre_commit)
    printf '\nfilename=%s\ncommit_type_arg=%s\ncommit_type=%s' \
        "${filename}" "${commit_type_arg}" "${commit_type}" |
        hooks_utility_debug "${ENSURE_FILE_CHANGED_DISPLAY_NAME}"

    if [[ "${commit_type}" != ${commit_type_arg}* ]]; then
        printf 'skipped, irrelevant commit type' |
            hooks_utility_debug "${ENSURE_FILE_CHANGED_DISPLAY_NAME}"
        return 0
    fi

    local when_phrase=''
    if [[ -n "${commit_type_arg}" ]]; then
        when_phrase=" when ${commit_type_arg}"
    fi

    # proceed ensuring  ----------------------------------------------------
    while IFS= read -r -d '' changed_file; do
        # search if filename is present in modified file list
        if [[ "${changed_file}" == "${filename}" ]]; then
            printf 'ensured file changed%s: %s' \
                "${when_phrase}" "${filename}" |
                hooks_utility_info "${ENSURE_FILE_CHANGED_DISPLAY_NAME}"
            return 0
        fi
    done < <(git diff --cached --name-only --diff-filter=M)

    # fail to find filename in changed file list
    printf 're %s%s: %s' "${filename}" "${when_phrase}" "${message}" |
        hooks_utility_error "${ENSURE_FILE_CHANGED_DISPLAY_NAME}"
    return 1

    # Todo print as log
}

# hooks_utility_ensure_line_modification()
#
# in pre-commit, ensure certain line(s) must be modified
#
# USAGE:
#   hooks_utility_ensure_line_modification FILE START_LINE END_LINE \
#           COMMIT_TYPE MESSAGE
#
# ARGUMENT:
#   FILE            file which is required to be changed,
#                   relative path to repo root
#   START_LINE      line number of start of check range in FILE
#   END_LINE        line number of end of check range in FILE
#   COMMIT_TYPE     when to perform check, q.v. get_commit_type_at_pre_commit()
#   MESSAGE         reason of failing this test
#
# RETURN:
#   0       success, range in FILE is edited; or skip b/c irrelevant COMMIT_TYPE
#   1       failure, range in FILE hasn't been edited
#
# EXAMPLE:
#   hooks_utility_ensure_line_modification "code.py" 1 5 \
#           'merge-binary-finish_feature' \
#           'must change algorithm per commit' \
hooks_utility_ensure_line_modification() {
    # Todo write
    # Todo print as log
    return 1
}

# hooks_utility_ensure_changelog_edited()
#
# in pre-commit, when merge to finish a feature branch,
# ensure CHANGELOG file is edited to reflect
#
# USAGE:
#   hooks_utility_ensure_changelog_edited CHANGELOG_FILE
#
#
# ARGUMENT:
#   CHANGELOG_FILE  file path of CHANGELOG file, relative path to repo root
#
# RETURN:
#   0       success
#   1       failure
#
# EXAMPLE:
#   hooks_utility_ensure_changelog_edited 'CHANGELOG.md'
hooks_utility_ensure_changelog_edited() {
    # Todo need test
    hooks_utility_ensure_file_modification "${1}" \
        'merge-binary-finish_feature' \
        "record changes of this feature branch"

    return "$?"
}

# hooks_utility_ensure_version_updated()
#
# in pre-commit, ensure file containing version is updated when release
#
# USAGE:
#   hooks_utility_ensure_version_updated FILE LINE
#
# ARGUMENT:
#   FILE            file which is required to be changed,
#                   relative path to repo root
#   LINE            line (in FILE) which version should be found
#
# RETURN:
#   0       success
#   1       failure
#
# EXAMPLE:
#   hooks_utility_ensure_version_updated 'project.ini' 5
hooks_utility_ensure_version_updated() {
    # Todo need test
    local filename line
    filename="${1}"
    line="${2}"

    hooks_utility_ensure_line_modification \
        "${filename}" "${line}" "${line}" \
        'merge-binary-release' \
        "update project version in the file"

    return "$?"
}

# constants  ===================================================================
ENSURE_FILE_CHANGED_DISPLAY_NAME="${HOOKS_UTILITY_DISPLAY_NAME}:EFM"
