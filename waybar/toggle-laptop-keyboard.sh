#!/bin/bash

CACHE_FILE="/home/sythe/.cache/laptop-keyboard-disabled"

if [ -f "$CACHE_FILE" ] ;then
    rm "$CACHE_FILE"
    sh -c "hyprctl keyword 'device[at-translated-set-2-keyboard]:enabled' 1"
else
    touch "$CACHE_FILE"
    sh -c "hyprctl keyword 'device[at-translated-set-2-keyboard]:enabled' 0"
fi
