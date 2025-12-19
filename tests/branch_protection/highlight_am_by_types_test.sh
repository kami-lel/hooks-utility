#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../hooks_utility.sh"

# tests for
# _highlight_am_by_types()

echo '_highlight_am_by_types() test' | hooks_utility_padding_centered '#'

# primary  ---------------------------------------------------------------------
echo 'primary' | hooks_utility_padding_centered '-'

_highlight_am_by_types "TODO"
printf '\n'

_highlight_am_by_types "BUG"
printf '\n'

_highlight_am_by_types "FIXME"
printf '\n'

_highlight_am_by_types "HACK"
printf '\n'

# secondary  -------------------------------------------------------------------
echo 'secondary' | hooks_utility_padding_centered '-'

_highlight_am_by_types "Todo"
printf '\n'

_highlight_am_by_types "Bug"
printf '\n'

_highlight_am_by_types "Fixme"
printf '\n'

_highlight_am_by_types "Hack"
printf '\n'

# tertiary  --------------------------------------------------------------------
echo 'tertiary' | hooks_utility_padding_centered '-'

_highlight_am_by_types "todo"
printf '\n'

_highlight_am_by_types "bug"
printf '\n'

_highlight_am_by_types "fixme"
printf '\n'

_highlight_am_by_types "hack"
printf '\n'
