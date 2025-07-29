#!/bin/bash

APPS=(
	bibata-cursor-theme-bin
	blueberry
	discord
	dracula-gtk-theme
	dracula-icons-theme
	eog
	eww-git
	gdm
	ghostty
	gnome-control-center
	google-chrome
	mpv
	nautilus
	neovim
	networkmanager
	niri
	obs-studio
	spotify-launcher
	telegram-desktop
	visual-studio-code-bin
	wlogout
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

	# Notifications
	inotify-tools
	libnotify
	mako

	# Timeshift
	timeshift-autosnap

	# Others
	bat
	curl
	ethtool
	fastfetch
	fuzzel
	fzf
	git
	gnome-keyring
	htop
	hypridle
	hyprlock
	jq
	less
	man-db
	nodejs
	npm
	ntfs-3g
	openssh
	os-prober
	playerctl
	pyenv
	ripgrep
	smartmontools
	starship
	swww
	tk
	tlp
	tmux
	trash-cli
	tree
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
	ttf-material-symbols-variable-git
	ttf-ms-win11-auto
	ttf-space-mono-nerd
)

SERVICES=(
	# System
	NetworkManager
	bluetooth
	gdm
	tlp

	# User
	pipewire
)
