# FIXME

echo \
"combined w/ time  ------------------------------------------------------------\
--"

hooks_utility_debug -d "Some Debugging Message Content" "MainComponent"
hooks_utility_debug -d "Some Debugging Message Content" "MainComponent"
hooks_utility_info -d "Content of Informational Message" "MainComponent"
hooks_utility_warning -d  "Warning!" "MainComponent"

echo \
"combined w/ date time  -------------------------------------------------------\
--"

hooks_utility_debug -dt "Some Debugging Message Content" \
        "Information Test Component from Main Script"
hooks_utility_debug -dt "Some Debugging Message Content" \
        "Information Test Component from Main Script"
hooks_utility_info -dt "Content of Informational Message" \
        "Information Test Component from Main Script"
hooks_utility_warning -dt "Warning!" \
        "Information Test Component from Main Script"