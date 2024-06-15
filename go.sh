#!/usr/bin/env bash

set -e -o pipefail

mkdir -p ~/logs/kingmaker

exec bundle exec rackup -p 4567 # --host 0.0.0.0 >> ~/logs/kingmaker/kingmaker.log 2>&1


