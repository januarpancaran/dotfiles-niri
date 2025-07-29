#!/bin/bash

case "$1" in
up)
	wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+
	;;
down)
	wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
	;;
*)
	wpctl set-volume @DEFAULT_AUDIO_SINK@ "$(echo $1 | awk '{print ($1 / 100)}')"
	;;
esac
