#!/bin/bash
# Kill any existing zscroll process for this bar to prevent duplicates
pkill -f "zscroll.*musicscroll" 2>/dev/null

# Add a small delay to ensure clean state
sleep 0.1

# Run zscroll with better error handling
zscroll -l 30 \
        --delay 0.2 \
        --scroll-padding " | " \
        --match-command "`dirname $0`/music_get.sh --status" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-check true "`dirname $0`/music_get.sh" 2>/dev/null &

# Store PID for cleanup
ZSCROLL_PID=$!

# Trap to clean up on exit
trap "kill $ZSCROLL_PID 2>/dev/null" EXIT

# Wait for zscroll to finish
wait $ZSCROLL_PID 2>/dev/null
# #!/bin/bash
# zscroll -l 30 \
#         --delay 0.1 \
#         --scroll-padding " | " \
#         --match-command "`dirname $0`/music_get.sh --status" \
#         --match-text "Playing" "--scroll 1" \
#         --match-text "Paused" "--scroll 0" \
#         --update-check true "`dirname $0`/music_get.sh" &
#
# wait
