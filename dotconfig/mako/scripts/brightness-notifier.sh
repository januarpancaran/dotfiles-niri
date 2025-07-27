#!/bin/bash

ICON_DIR="$HOME/.config/mako/icons"

function send_notification() {
	BRIGHTNESS=$(brightnessctl get)
	MAX_BRIGHTNESS=$(brightnessctl max)
	PERCENTAGE=$((BRIGHTNESS * 100 / MAX_BRIGHTNESS))
	makoctl dismiss -a "changebrightness"
	notify-send -a "changebrightness" -u low -r 9994 -h int:value:"$PERCENTAGE" -i "$ICON_DIR/brightness-change.png" "Brightness: ${PERCENTAGE}%" -t 2000
}

case $1 in
up)
	brightnessctl set +5%
	send_notification
	;;
down)
	brightnessctl set 5%- --min-value=1
	send_notification
	;;
esac
