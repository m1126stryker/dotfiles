#! /bin/bash

# Script for sway-bar status label command
# Weather shall be updated by its dedicated daemon and script checks only for its updated output
# All other status fields are updated every second while for weather its up to its daemon

KBLAYOUT=" $(swaymsg -p -t get_inputs | awk -F "AT_Translated_Set_2_keyboard" '/Active Keyboard Layout/ { print $1; exit; }' | awk '{ print toupper(substr($4,1,2)) }') "

BAT=$(acpi --battery | grep -o -P '.{0,3}%' )
if [[ $(acpi --ac-adapter | awk '{print $3}') == "on-line" ]]; then
	BAT=" ${BAT} 󱐥 "
else
	BAT=" ${BAT}  "
fi

VOL=" M "
PACMUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print$2}')
if [[ $PACMUTE == "no" ]]; then
	VOL=" $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print$5}')";
	#if [[ "$VOL" == " 100%" ]]; then
	#	VOL=${VOL:1:4};
	#fi
fi

DATETIME="  $(date +'%a %Y-%m-%d %R:%S')"

PLAYERCTL=""
PLMAX=30
if [[ $(playerctl status) != "Stopped" ]]; then
	PLAYERCTL=$(playerctl metadata --format '{{trunc(default(uc(playerName),NA),10)}} ({{status}}): {{trunc(title,20)}}  {{trunc(artist,15)}}');
fi
PLENGTH=${#PLAYERCTL}
YESIMSTUPID="                     "
WHITE=${YESIMSTUPID:$( expr $(expr $PLMAX - $PL) / 2 )}
PLAYERCTL="$WHITE$PLAYERCTL$WHITE"

NETWORKSTATUS="$(nmcli device status | tail -n +2 | head -n 1 | awk '{print toupper($2)}')"
NETWORKSTATUS=" ${NETWORKSTATUS:0:4} "
if [[ $NETWORKSTATUS == "lo" ]]; then
	NETWORKSTATUS=" N:NA "
fi

BLUETOOTHSTATUS=$(bluetoothcli show $(bluetoothcli list | head -n 1 | awk '{print $2}') | awk '/Powered/ {print $2}')

CPUTEMP=$(sensors | awk '/CPU/ {print $2}')
CPUTEMP=" ${CPUTEMP:(-6):(-4)}° "

WEATHER=" $(cat $HOME/.config/sway/scripts/weathernow)° "

 echo "$PLAYERCTL  $CPUTEMP$WEATHER$NETWORKSTATUS$KBLAYOUT$VOL$DATETIME$BAT"
