#!/bin/bash

direction=$1
current=$2

case "$direction" in
down)
	target=$((current + 1))
	if [[ "$target" == 11 ]]; then
		exit 0
	fi
	niri msg action focus-workspace "$target"
	;;
up)
	target=$((current - 1))
	niri msg action focus-workspace "$target"
	;;
esac
