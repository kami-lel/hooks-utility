################################################################################
# hooks_utility.sh
# a collections of utility functions for git hooks
#
# author:  kamiLeL
# version: v1.0.0
################################################################################

#  message  #################################################################

ANSI_COLOR_RED='\e[0;31m'
ANSI_RESET='\e[0m'

# _hooks_utility_generate__message - create standardized log messages
# Arguments:
#   message     message content (String)
# other args: if date/time, if coloring, stdout/stderr
_hooks_utility_generate__message() { 
    # TODO
    local message="$1"
    echo -e "${ANSI_COLOR_RED}$message${ANSI_RESET}"
}


# hooks_utility__debug - print debug message  -------------------------------
# hooks_utility__debug() {}

# hooks_utility__info() {}

# hooks_utility__warning() {}

# hooks_utility__error() {}

# hooks_utility__critical() {}




# search annotation markers  ###################################################

# todo
# hooks_utility_pre_merge_test_annotation_markers() {}
