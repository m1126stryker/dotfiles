#! /bin/bash

swaymsg \[title="COMMANDEXEC"\] kill

alacritty -T "COMMANDEXEC" --hold -e $($() | wmenu -b)
