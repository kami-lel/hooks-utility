#!/bin/bash

# shellcheck source=/dev/null
source "$(dirname "${BASH_SOURCE[0]}")/../../scripts/hooks/hooks_utility.sh"

echo \
"tests: log style message, multiple lines  #####################################\
##"

hooks_utility_info "This informational message is intentionally long and spans \
multiple lines to test wrapping and handling by the logging function.
It includes several paragraphs and list-like lines to increase length and \
variety:
- First bullet: explains the context and expected behavior.
- Second bullet: adds more detail and edge-case notes that might affect
  output formatting.
Additional paragraph to make the content even longer and ensure the logger\
preserves newlines and spacing correctly.
End of informational message."

hooks_utility_error "Error: Failed to process request: configuration parse
failure
    at parse_config (config_parser.sh:132)
    at load_configuration (init.sh:58)
    at main (app.sh:22)
Caused by: Unexpected token '}' in line 45 of config.yaml
    near:
        database:
          host: localhost
          user: app_user
          password: pass}word
Suggestion: check configuration file for syntax errors and escape
special characters."
