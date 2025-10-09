################################################################################
# hooks_utility.sh
# a collections of utility functions for git hooks
#
# author:  kamiLeL
# version: v1.0.0
################################################################################

# log message  #################################################################

# TODO
# _hooks_utility_generate_log_message - create standardized log messages
# Arguments:
#   message     message content (String)
# other args: if date/time, if coloring, stdout/stderr
_hooks_utility_generate_log_message() { 
    local message = "$1"
    echo $1
}


# hooks_utility_log_debug - print debug message  -------------------------------
hooks_utility_log_debug() {
}

hooks_utility_log_info() {}

hooks_utility_log_warning() {}

hooks_utility_log_error() {}

hooks_utility_log_critical() {}




# search annotation markers  ###################################################

# todo
hooks_utility_pre_merge_test_annotation_markers() {}
