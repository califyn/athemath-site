#!/bin/bash

set -euo pipefail

EXEMPT_TIDY_ARRAY=(html/{header,footer}.html html/catalog/{header,footer}.html)

readarray -t HTML_PRETTIER_ARRAY <"index.html"
readarray -t HTML_PRETTIER_ARRAY < <(git ls-files './html/*.html')

HTML_TIDY_ARRAY=("${HTML_PRETTIER_ARRAY[@]}")
for target in "${EXEMPT_TIDY_ARRAY[@]}"; do
  for i in "${!HTML_TIDY_ARRAY[@]}"; do
    if [[ ${HTML_TIDY_ARRAY[i]} == "$target" ]]; then
      unset 'HTML_TIDY_ARRAY[i]'
    fi
  done
done

tidy -config tidyrc -qe "${HTML_TIDY_ARRAY[@]}"
if command -v prettier; then
  prettier --check "${HTML_PRETTIER_ARRAY[@]}"
fi
