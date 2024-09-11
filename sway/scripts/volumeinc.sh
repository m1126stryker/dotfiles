#! /bin/bash

if [[ $(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '.{1,3}(?=%)' | head -n 1) -lt 100 ]] then exec pactl set-sink-volume @DEFAULT_SINK@ +5% ; else exec echo ; fi
