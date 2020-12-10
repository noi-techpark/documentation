#!/bin/bash

set -xeo pipefail

# Remove trailing whitespace characters
sed -i 's/[ \t]*$//' ./*.md

# Create or update the table of contents
doctoc ./*.md

# Push to the server
git commit -am "Update FLIGHTRULES.md"
git push

exit 0

