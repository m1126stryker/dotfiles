#! /bin/bash

# Retreiving data from the output of 2 different daemon scripts running in the background to-
# minimize the time delay resultinf from handling them all on fly

readarray -t STATUS < <(cat $HOME/.config/sway/scripts/status_data/lazy_info)
KBLAYOUT=${STATUS[0]}
BAT=${STATUS[1]}
VOL=${STATUS[2]}
DATETIME="  $(date +'%a %Y-%m-%d %R:%S')"
PLAYERCTL=${STATUS[3]}
NETWORKSTATUS=${STATUS[4]}
BLUETOOTHSTATUS=${STATUS[5]}
CPUTEMP=${STATUS[6]}
WEATHER=${STATUS[7]}
SPACES=${STATUS[8]}

echo "$PLAYERCTL\
$SPACES\
$CPUTEMP\
$WEATHER\
$NETWORKSTATUS\
$KBLAYOUT\
$VOL\
$DATETIME$BAT\
$BLUETOOTHSTATUS"
