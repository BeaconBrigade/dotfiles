#!/bin/bash

FSWATCH="/opt/homebrew/bin/fswatch"
WATCH_DIR="/Users/rcullen/Pictures/Canon EOS 60D/darktable_exported"
RUNNER="/Users/rcullen/.local/bin/run-auto-import.sh"

if [ ! -x "$FSWATCH" ]; then
  echo "fswatch not found at $FSWATCH" >> /tmp/auto-import.err
  exit 1
fi

"$FSWATCH" -0 -r "$WATCH_DIR" \
  | /usr/bin/xargs -0 -n 1 "$RUNNER"
