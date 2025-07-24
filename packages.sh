#!/bin/bash

APPS=(
	bibata-cursor-theme-bin
	blueberry
	discord
	dracula-gtk-theme
	dracula-icons-theme
	ghostty
	gnome-control-center
	google-chrome
	mpv
	nautilus
	neovim
	networkmanager
	niri
	obs-studio
	papirus-icon-theme
	spotify-launcher
	telegram-desktop
	visual-studio-code-bin
)

UTILS=(
	# Sound
	alsa-firmware
	alsa-utils
	pipewire
	pipewire-alsa
	pipewire-pulse
	wireplumber

	# Backlight
	acpi
	brightnessctl

	# Bluetooth
	bluez
	bluez-utils

	# Storage
	gvfs

	# AUTH
	polkit-gnome
	xorg-xhost

	# Timeshift
	timeshift-autosnap

	# Others
	bat
	curl
	fastfetch
	fzf
	git
	htop
	nodejs
	npm
	openssh
	playerctl
	ripgrep
	starship
	tlp
	tmux
	trash-cli
	unrar
	unzip
	wget
	wl-clipboard
	xdg-desktop-portal-gnome
	xdg-desktop-portal-gtk
	xwayland-satellite
	xwaylandvideobridge
	yazi
	zip
	zoxide
	zsh
)

FONTS=(
	noto-fonts-cjk
	noto-fonts-emoji
	otf-font-awesome
	ttf-jetbrains-mono-nerd
	ttf-space-mono-nerd
	ttf-ms-win11-auto
)

SERVICES=(
	# System
	NetworkManager
	bluetooth
	tlp

	# User
	pipewire
)
