#!/usr/bin/env bash

theme="powermenu"
dir="$HOME/.config/rofi/themes"

uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/$theme"

# Options
shutdown="shutdown"
reboot="reboot"
lock="lock"
suspend="suspend"
logout="logout"


# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
		systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $lock)
		slock -l
        ;;
    $suspend)
			amixer set Master mute
			systemctl suspend
        ;;
    $logout)
		loginctl terminate-user annie
        
        ;;
esac
