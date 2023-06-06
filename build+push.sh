#!/bin/bash

# SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>
#
# SPDX-License-Identifier: GPL-3.0-only

set -xeo pipefail

# Remove trailing whitespace characters
sed -i 's/[ \t]*$//' ./*.md
sed -i 's/[ \t]*$//' ./snippets/*.md

# Create or update the table of contents
doctoc ./*.md
doctoc ./snippets/*.md

# Push to the server
git commit -am "Update flight rules"
git push

exit 0

