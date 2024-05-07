#!/bin/sh

if command -v pamixer &>/dev/null; then
    if [ true == $(pamixer --get-mute) ]; then
        echo 0
        exit
    else
        pamixer --get-volume
    fi
else
    amixer -D pulse sget Master | awk -F '[^0-9]+' '/Left:/{print $3}'
fi
# if eww list-windows | rg -q "\*volume"; then
#     eww update volume-level=$(pamixer --get-volume)
#     eww update volume-muted=$(pamixer --get-mute)
#     eww update volume-hidden=false
# else
#     eww close brightness
#     eww open volume

#     eww update volume-level=$(pamixer --get-volume)
#     eww update volume-muted=$(pamixer --get-mute)
#     eww update volume-hidden=false
#     sleep 2
#     eww update volume-hidden=true
#     sleep 1
#     eww close volume
# fi
