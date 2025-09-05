#!/bin/sh

# A dwm_bar function that shows the current artist, track, position, duration, and status from mpc
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: mpc

dwm_mpc () {
    if ps -C mpd > /dev/null; then
        ARTIST=$(mpc -h 127.0.0.1 current -f %artist%)
        TRACK=$(mpc -h 127.0.0.1 current -f %title%)
        POSITION=$(mpc -h 127.0.0.1 status | grep "%)" | awk '{ print $3 }' | awk -F/ '{ print $1 }')
        DURATION=$(mpc -h 127.0.0.1 current -f %time%)
        STATUS=$(mpc -h 127.0.0.1 status | sed -n 2p | awk '{print $1;}')
        SHUFFLE=$(mpc -h 127.0.0.1 status | tail -n 1 | awk '{print $6}')

        if [ "$IDENTIFIER" = "unicode" ]; then
            if [ "$STATUS" = "[playing]" ]; then
                STATUS=""
            else
                STATUS=""
            fi

            if [ "$SHUFFLE" = "on" ]; then
                SHUFFLE=" "
            else
                SHUFFLE=""
            fi
        else
            if [ "$STATUS" = "[playing]" ]; then
                STATUS="PLA"
            else
                STATUS="PAU"
            fi

            if [ "$SHUFFLE" = "on" ]; then
                SHUFFLE=" S"
            else
                SHUFFLE=""
            fi
        fi
        
        printf "%s%s %s-%s %s/%s%s%s" "$SEP1" "$STATUS" "$ARTIST" "$TRACK" "$POSITION" "$DURATION" "$SHUFFLE" "$SEP2"
    fi
}

dwm_mpc
