#!/bin/bash

case "$1" in
up)
	brightnessctl set 5%+
	;;
down)
	brightnessctl set 5%- --min-value=1
	;;
esac
