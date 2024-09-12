#! /bin/bash

# Script for generating the lazy data for sway-bar status label command
# What i mean by lazy is that it doesnt need to be accuratly synchronised with DATETIME since retrieving all those-
# variables in parallel with time results a +100ms time delay (a funny clock label upadting seconds every 1.2 seconds somehow)
# Something that made time label largely inaccurate
# Weather is updated through its dedicated daemon script and this only checks for its regurally updated output
# All other status fields are updated every second updating the lazy_info file in the following order
# keyboard layout
# battery
# volume
# playerctl
# network
# bluetooth
# cputemp
# weather
# whitespaces
#
FILE="$HOME/.config/sway/scripts/status_data/lazy_info"
echo > $FILE
while  :
do
	#KEYBOARD
	KBLAYOUT=" $(swaymsg -p -t get_inputs | awk -F "AT_Translated_Set_2_keyboard" '/Active Keyboard Layout/ { print $1; exit; }' | awk '{ print toupper(substr($4,1,2)) }') "

	#BATTERY
	BAT=$(acpi --battery | grep -o -P '.{0,3}%' )
	if [[ $(acpi --ac-adapter | awk '{print $3}') == "on-line" ]]; then
		BAT=" ${BAT} 󱐥 "
	else
		BAT=" ${BAT}  "
	fi
		
	#VOLUME
	VOL=" M "
	PACMUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print$2}')
	if [[ $PACMUTE == "no" ]]; then
		VOL=" $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print$5}')";
	fi
		
	#PLAYERCTL
	PLAYERCTL=""
	if [[ $(playerctl status) != "Stopped" ]]; then
		PLAYERCTL=$(playerctl metadata --format '{{trunc(default(uc(playerName),NA),10)}} ({{status}}): {{trunc(title,20)}}  {{trunc(artist,15)}}');
	fi
		
	#NETWORK
	NETWORKSTATUS="$(nmcli device status | tail -n +2 | head -n 1 | awk '{print toupper($2)}')"
	NETWORKSTATUS=" ${NETWORKSTATUS:0:4} "
	if [[ $NETWORKSTATUS == " LOOP " ]]; then
		NETWORKSTATUS=" N:NA "
	fi	

	#BLUETOOTH
	BLUETOOTHSTATUS=$(bluetoothctl show $(bluetoothctl list | head -n 1 | awk '{print $2}') | awk '/Powered/ {print $2}')
	if [[ $BLUETOOTHSTATUS == "yes" ]]; then
		BLUETOOTHSTATUS="󰂯 "
	else
		BLUETOOTHSTATUS=""
	fi
	
	#CPUTEMP
	CPUTEMP=$(sensors | awk '/CPU/ {print $2}')
	CPUTEMP=" ${CPUTEMP:(-6):(-4)}° "
	
	#WEATHER
	WEATHER="$(cat ./.config/sway/scripts/status_data/weather)"

	# Total Width With 1 Workspace, MesloLGMNerdFont Mono 11 = 210, Each WS indicator element is almost 2 chars wide
	# DATETIME length is hardcoded as 25 -> DATETIME="  $( date '%a %Y-%m-%d %R:%S' )"
	# Total length of the whole status :
	LENGTH=$(( ${#BLUETOOTHSTATUS} + ${#BAT} + 25 + ${#VOL} + ${#KBLAYOUT} + ${#NETWORKSTATUS} + ${#WEATHER} + ${#CPUTEMP} + ${#PLAYERCTL} ))
	# 210 ( 209 to be better adapted to the slow update interval (1s) ) - (Workspace indicators width + ALL of the Status's Width) :
	WSLEN=$(( 209 - $(swaymsg -p -t get_workspaces | grep -c Workspace) * 2 - $LENGTH ))
	SPACES="$(printf '%*s' "$WSLEN")"

	sleep 1
	echo -e "$KBLAYOUT\n$BAT\n$VOL\n$PLAYERCTL\n$NETWORKSTATUS\n$BLUETOOTHSTATUS\n$CPUTEMP\n$WEATHER\n$SPACES" > $FILE
done
