#!/bin/bash

echo "filename,title,last_updated"
for file in $(find . -name "*.html"); do
    # Extract the title
    title=$(cat "$file" | pup 'title text{}' |  awk 'BEGIN{RS=ORS="";}{gsub(/^[ \t\n]+|[ \t\n]+$/, "", $0); print $0}')

    # Extract the last update time within the specific context
    last_update=$(awk '/<dt class="govuk-body govuk-!-margin-bottom-0">Last update:<\/dt>/ {getline; getline; split($0, a, "\""); print a[2]}' "$file")

    echo "$file,\"$title\",$last_update"
done
