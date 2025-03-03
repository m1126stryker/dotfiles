#! /bin/bash

# Script for generating the lazy data for sway-bar status label command
# What i mean by lazy is that it doesnt need to be accuratly synchronised with DATETIME since retrieving all those-
# variables in parallel with time results a +100ms time delay (a funny clock label upadting seconds every 1.2 seconds somehow)
# Something that made time label largely inaccurate
# Weather is updated through its dedicated daemon script and this only checks for its regurally updated output
pkill -O 1 statusd.sh
WEATHER_DAT="/tmp/swayweather"
FILE="/tmp/swaylazy_info"
echo > $FILE
while  :
do
	#KEYBOARD
	KBLAYOUT=" $(swaymsg -t get_inputs | jq -r '.[] | select(.identifier =="1:1:AT_Translated_Set_2_keyboard") |.xkb_active_layout_name[0:2]|ascii_upcase') "
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
	if [[ $(playerctl status 2> /dev/null) != "Stopped" ]]; then
		PLAYERCTL=$(playerctl metadata --format '{{trunc(default(uc(playerName),NA),10)}} ({{status}}): {{trunc(title,20)}}  {{trunc(artist,15)}}' 2> /dev/null);
	fi
		
	#NETWORK
	NETWORKSTATUS="$(nmcli -f TYPE -t device status | awk '{print toupper($1); exit;}')"
	NETWORKSTATUS=" ${NETWORKSTATUS:0:4} "
	if [[ $NETWORKSTATUS == " LOOP " ]]; then
		NETWORKSTATUS=" N:NA "
	fi	

	#BLUETOOTH
	BLUETOOTHSTATUS=$(bluetoothctl show $(bluetoothctl list | awk '{print $2;exit;}') | awk '/Powered/ {print $2}')
	if [[ $BLUETOOTHSTATUS == "yes" ]]; then
		BLUETOOTHSTATUS="󰂯 "
	else
		BLUETOOTHSTATUS=""
	fi
	
	#CPUTEMP
	CPUTEMP=" $(sensors -j 2> /dev/null | jq -r '."thinkpad-isa-0000"."CPU"."temp1_input"|round')° "  
	
	#WEATHER
	WEATHER="$(cat $WEATHER_DAT)"

	# Total Width With 1 Workspace, MesloLGMNerdFont Mono 11 = 210, Each WS indicator element is almost 2 chars wide
	# DATETIME length is hardcoded as 25 -> DATETIME="  $( date '%a %Y-%m-%d %R:%S' )"
	# NETWORKSTATUS length is hardcoded as 6 as it takes first 4 chars of the active network adding two spaces at both ends
	# KBLAYOUT length is hardcoded as 4 for the same reason
	# Total length of the whole status :
	LENGTH=$(( ${#BLUETOOTHSTATUS} + ${#BAT} + 25 + ${#VOL} + 4 + 6 + ${#WEATHER} + ${#CPUTEMP} + ${#PLAYERCTL} ))
	# 210 ( 209 to be better adapted to the slow update interval (1s) ) - (Workspace indicators width + ALL of the Status's Width) :
	WSLEN=$(( 213 - $(swaymsg -p -t get_workspaces | grep -c Workspace) * 2 - $LENGTH ))
	SPACES="$(printf '%*s' "$WSLEN")"

	echo -e "$KBLAYOUT\n$BAT\n$VOL\n$PLAYERCTL\n$NETWORKSTATUS\n$BLUETOOTHSTATUS\n$CPUTEMP\n$WEATHER\n$SPACES" > $FILE
	sleep 1;
done
