#!/usr/bin/env bash

# Dependencies: hyprsunset, khal, taskwarrior, notify-send, sunwait, curl, jq

# Get Latitude & Longitude Automatically
GEO_DATA=$(curl -s "https://ipinfo.io/json" | jq -r '.loc')
if [[ -z "$GEO_DATA" ]]; then
    # Fallback location (Berlin Baby)
    LAT="52.5200N"
    LON="13.4050E"
else
    LAT=$(echo "$GEO_DATA" | cut -d',' -f1)N
    LON=$(echo "$GEO_DATA" | cut -d',' -f2)E
fi

# Get sunrise and sunset times using `sunwait`
SUNRISE=$(sunwait list rise $LAT $LON)
SUNSET=$(sunwait list set $LAT $LON)
CURRENT_TIME=$(date +%H:%M)

# Convert times to comparable format
SUNRISE_SEC=$(date -d "$SUNRISE" +%s)
SUNSET_SEC=$(date -d "$SUNSET" +%s)
CURRENT_SEC=$(date +%s)

# Manage hyprsunset
if [ "$CURRENT_SEC" -ge "$SUNSET_SEC" ]; then
    # Enable Hyprsunset if past sunset
    pgrep hyprsunset > /dev/null || hyprsunset &
elif [ "$CURRENT_SEC" -ge "$SUNRISE_SEC" ] && pgrep hyprsunset > /dev/null; then
    # Disable Hyprsunset if past sunrise and exists
    pkill hyprsunset
fi

# Notify about upcoming events in Khal
# EVENTS=$(khal list now 1h --format "{start-time}: {title}")
# if [[ ! -z "$EVENTS" ]]; then
#     notify-send "Upcoming Event(s)" "$EVENTS"
# fi

# Notify about upcoming tasks in Taskwarrior
TASKS=$(task due.before:1h status:pending export | jq -r '.[] | "\(.due) - \(.description)"')
if [[ ! -z "$TASKS" ]]; then
    notify-send "Upcoming Task(s) Deadline" "$TASKS"
fi
