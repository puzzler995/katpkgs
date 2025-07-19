#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="$HOME/.config/nightbot-now-playing"
SCRIPT_DIR="@SCRIPT_DIR@"

mkdir -p "$CONFIG_DIR"
cd "$CONFIG_DIR"

for f in auth.json config.json; do
    if [ ! -f "$f" ]; then
        cp "$SCRIPT_DIR/$f" .
        echo "Created default $f in $CONFIG_DIR. Please edit it."
    fi
done

exec @PYTHON@ "$SCRIPT_DIR/nowplaying.py"