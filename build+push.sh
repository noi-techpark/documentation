#!/bin/bash

set -xeo pipefail

doctoc FLIGHTRULES.md
git commit -am "Update FLIGHTRULES.md"
git push

exit 0

