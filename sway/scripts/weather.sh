#! /bin/bash

fnow="$HOME/.config/sway/scripts/status_data/weather"
echo "NA °C" > $fnow
sleep 5
while  :
do
	latlong=$(curl "https://ipinfo.io" --connect-timeout 5 -s | jq '.loc')
	weather=$(curl "https://api.open-meteo.com/v1/forecast?latitude=${latlong:1:7}&longitude=${latlong:9:7}&current=temperature_2m&timezone=auto&models=icon_seamless" --connect-timeout 5 -s)
	
	if [[ -n $weather ]]; then
		temp=$(echo $weather | jq '.current.temperature_2m')
		unit=$(echo $weather | jq '.current_units.temperature_2m')
		echo " $temp${unit:1:2} "  > $fnow;
		sleep $(echo $weather | jq '.current.interval');
	else
		echo " NA °C " > $fnow
		sleep 60
	fi
done
