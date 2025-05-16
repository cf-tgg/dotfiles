#!/bin/bash

OUTPUT_FILE="$HOME/.cache/mpvq/mpvq.playlist"

if [[ -z "$QUTE_HINT_URL" ]]; then
    echo "No URL provided" > "$QUTE_FIFO"
    exit 1
fi

echo "$QUTE_HINT_URL" >> "$OUTPUT_FILE"
echo "URL appended to $OUTPUT_FILE" > "$QUTE_FIFO"
