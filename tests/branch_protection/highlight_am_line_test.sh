#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

# tests for
# _highlight_am_line_in_git_diff_cached

echo '_highlight_am_line_in_git_diff_cached() test' |
    hooks_utility_padding_centered '#'

# py ===========================================================================
echo 'in Python' | hooks_utility_padding_centered '='
# primary  ---------------------------------------------------------------------
echo 'primary' | hooks_utility_padding_centered '-'
pattern="${PRIMARY_AM_PATTERN}"

_highlight_am_line_in_git_diff_cached \
    'def process_data(data):  # TODO: implement streaming parser' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    'result = legacy_api_call()  # HACK: workaround for broken API' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    '# FIXME: this raises on negative values' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    'parsed = parse_json(raw)  # BUG: raises KeyError when "id" is missing' \
    "${pattern}"
printf '\n'

# secondary  -------------------------------------------------------------------
echo 'secondary' | hooks_utility_padding_centered '-'
pattern="${SECONDARY_AM_PATTERN}"

_highlight_am_line_in_git_diff_cached \
    '# Todo: add unit tests' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    'items = list(dict.fromkeys(items))   # Hack: de-duplicate' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    'value = compute(x)  # Fixme: incorrect for large x' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    '# Bug: off-by-one causes last item to be dropped in the response' \
    "${pattern}"
printf '\n'

# tertiary  --------------------------------------------------------------------
echo 'tertiary' | hooks_utility_padding_centered '-'
pattern="${TERTIARY_AM_PATTERN}"

_highlight_am_line_in_git_diff_cached \
    'config["timeout"] = 30  # todo: make value configurable' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    'if env == 'prod': max_workers = 1  # Hack: limit parallelism' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    'handle_connection(conn)  # fixme: leaks sockets when timeout occurs' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    'send_message(msg)  # bug: occasionally sends'
"${pattern}"
printf '\n'

# c ============================================================================
echo 'in C' | hooks_utility_padding_centered '='
# primary  ---------------------------------------------------------------------
echo 'primary' | hooks_utility_padding_centered '-'
pattern="${PRIMARY_AM_PATTERN}"

_highlight_am_line_in_git_diff_cached \
    'int compute(); // TODO: implement efficient algorithm for large inputs' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    'int workaround_flag = 1; // HACK: temporary bypass for legacy behavior' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    'size_t len = strlen(s); // FIXME: wrong for multibyte UTF-8 strings' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    'result = result / divisor; // BUG: division by zero possible if divisor unset' \
    "${pattern}"
printf '\n'

# secondary  -------------------------------------------------------------------
echo 'secondary' | hooks_utility_padding_centered '-'
pattern="${SECONDARY_AM_PATTERN}"

_highlight_am_line_in_git_diff_cached \
    'char *config_path = NULL; // Todo: load from environment or default location' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    'buffer[pos++] = ch; // Hack: assumes buffer has space; fix proper bounds checking' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    'if (ptr == NULL) return -1; // Fixme: inconsistent error handling across callers' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    'send_packet(pkt); // Bug: may send duplicate packets under heavy load' \
    "${pattern}"
printf '\n'

# tertiary  --------------------------------------------------------------------
echo 'tertiary' | hooks_utility_padding_centered '-'
pattern="${TERTIARY_AM_PATTERN}"

_highlight_am_line_in_git_diff_cached \
    '// todo: add validation for user-supplied parameters before use' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    '// hack: using global state to avoid refactor; remove when possible' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    '// fixme: race condition when accessed from multiple threads' \
    "${pattern}"
printf '\n'

_highlight_am_line_in_git_diff_cached \
    '// bug: memory leak if init_resource() fails before cleanup' \
    "${pattern}"
printf '\n'
