#! /bin/bash

# Retreiving data from the output of 2 different daemon scripts running in the background to-
# minimize the time delay resultinf from handling them all on fly

FILE="$HOME/.config/sway/scripts/status_data/lazy_info"
KBLAYOUT=$(sed '1q;d' $FILE)
BAT=$(sed '2q;d' $FILE)
VOL=$(sed '3q;d' $FILE )
DATETIME="  $(date +'%a %Y-%m-%d %R:%S')"
PLAYERCTL=$(sed	'4q;d' $FILE)
NETWORKSTATUS=$(sed '5q;d' $FILE)
BLUETOOTHSTATUS=$(sed '6q;d' $FILE)
CPUTEMP=$(sed '7q;d' $FILE)
WEATHER=$(sed '8q;d' $FILE)
SPACES=$(sed '9q;d' $FILE)

echo "$PLAYERCTL\
$SPACES\
$CPUTEMP\
$WEATHER\
$NETWORKSTATUS\
$KBLAYOUT\
$VOL\
$DATETIME$BAT\
$BLUETOOTHSTATUS"
