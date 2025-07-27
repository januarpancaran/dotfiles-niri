#!/bin/bash

command_exists() {
	command -v "$1" &>/dev/null
}

# Checking sudo command
SUDO_CMD=""

if command_exists sudo; then
	SUDO_CMD="sudo"
elif command_exists doas; then
	SUDO_CMD="doas"
else
	echo "No sudo command detected!"
	exit 1
fi

# Checking AUR Helper
AUR_HELPER=""

install_aur_helper() {
	HELPER="$1"
	TMP_HELPER_DIR=$(mktemp -d -t aur-helper-XXXXXX)

	"${SUDO_CMD}" pacman -Syu --noconfirm git
	git clone https://aur.archlinux.org/"${HELPER}".git "${TMP_HELPER_DIR}"
	(cd "${TMP_HELPER_DIR}" && makepkg -si --noconfirm)
	rm -rf "${TMP_HELPER_DIR}"

	check_aur_helper
}

check_aur_helper() {
	if command_exists yay; then
		AUR_HELPER="yay"
	elif command_exists paru; then
		AUR_HELPER="paru"
	else
		echo "No AUR Helper detected!"
		echo "Choose AUR Helper to install: [1 or 2]: "
		echo "1) yay"
		echo "2) paru"
		read -p "Enter your choice: [1 or 2]: " aur_choice

		case "$aur_choice" in
		1)
			echo "Installing yay..."
			install_aur_helper yay
			AUR_HELPER="yay"
			;;

		2)
			echo "Installing paru..."
			install_aur_helper paru
			AUR_HELPER="paru"
			;;
		*)
			echo "Invalid choice."
			exit 1
			;;
		esac
	fi
}

check_aur_helper

install_pkg() {
	"${AUR_HELPER}" -Syu --noconfirm "$@"
}

source packages.sh

echo "Installing packages..."
install_pkg "${APPS[@]}"

echo "Installing Utils..."
install_pkg "${UTILS[@]}"

echo "Installing Fonts..."
install_pkg "${FONTS[@]}"

# TLP config
TLP_CONF="/etc/tlp.conf"
"${SUDO_CMD}" tee "${TLP_CONF}" >/dev/null <<EOF
TLP_ENABLE=1
TLP_DEFAULT_MODE=BAT
TLP_PERSISTENT_DEFAULT=0
RUNTIME_PM_ENABLE=01:00.0
RUNTIME_PM_ON_AC=auto
RUNTIME_PM_ON_BAT=auto
NMI_WATCHDOG=0
MEM_SLEEP_ON_AC=s2idle
MEM_SLEEP_ON_BAT=deep
SOUND_POWER_SAVE_ON_AC=1
SOUND_POWER_SAVE_ON_BAT=1
WIFI_PWR_ON_AC=on
WIFI_PWR_ON_BAT=on
PLATFORM_PROFILE_ON_AC=performance
PLATFORM_PROFILE_ON_BAT=low-power
CPU_SCALING_GOVERNOR_ON_AC=performance
CPU_SCALING_GOVERNOR_ON_BAT=powersave
CPU_ENERGY_PERF_POLICY_ON_AC=performance
CPU_ENERGY_PERF_POLICY_ON_BAT=power
CPU_MIN_PERF_ON_AC=0
CPU_MAX_PERF_ON_AC=100
CPU_MIN_PERF_ON_BAT=0
CPU_MAX_PERF_ON_BAT=30
CPU_BOOST_ON_AC=1
CPU_BOOST_ON_BAT=0
CPU_HWP_DYN_BOOST_ON_AC=1
CPU_HWP_DYN_BOOST_ON_BAT=0
EOF

echo "Enabling services..."
for service in "${SERVICES[@]}"; do
	if [ "$service" = "pipewire" ]; then
		systemctl enable --user "$service"
	else
		"${SUDO_CMD}" systemctl enable "$service"
	fi
done

echo "Copying config files..."
CONF_SRC="./dotconfig"
CONF_DIR=""

if [ -d "$XDG_CONFIG_HOME" ]; then
	CONF_DIR="$XDG_CONFIG_HOME"
else
	if [ ! -d "$HOME/.config" ]; then
		mkdir -p "$HOME/.config"
	fi

	CONF_DIR="$HOME/.config"
fi

for item in "${CONF_SRC}"/*; do
	name=$(basename "$item")
	if [ -d "${CONF_DIR}/${name}" ]; then
		mv -v "${CONF_DIR}/${name}" "${CONF_DIR}/${name}.bak"
	fi

	cp -r "${item}" "${CONF_DIR}"
done

"${SUDO_CMD}" ln -s /usr/share/themes/Dracula/gtk-4.0 $HOME/.config/gtk-4.0
"${SUDO_CMD}" ln -s /dev/null /etc/udev/rules.d/61-gdm.rules

read -p "Change shell to zsh? [y/N] " shell_choice
if [[ "$shell_choice" =~ ^[Yy]$ ]]; then
	cp .zshrc "$HOME"
	chsh -s "$(which zsh)"
fi

# TPM for tmux
TPM_DIR="$HOME/.config/tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
	git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm
fi

install_nvim_config() {
	NVIM_DIR="$HOME/.config/nvim"
	TMP_NVIM_DIR=$(mktemp -d -t neovim-config-XXXXXX)

	if [ -d "${NVIM_DIR}" ]; then
		mv "${NVIM_DIR}" "${NVIM_DIR}".bak
	fi

	git clone https://github.com/januarpancaran/neovim-config.git "${TMP_NVIM_DIR}"
	mkdir -p "${NVIM_DIR}"
	cp -r "${TMP_NVIM_DIR}"/{lua,init.lua} "$NVIM_DIR"

	rm -rf "${TMP_NVIM_DIR}"
}

read -p "Install my neovim config? [y/N] " nvim_choice
if [[ "$nvim_choice" =~ ^[Yy]$ ]]; then
	install_nvim_config
fi

read -p "Enable autologin? [y/N] " autologin_choice
if [[ "$autologin_choice" =~ ^[Yy]$ ]]; then
	USERNAME=$(whoami)
	AUTOLOGIN_DIR="/etc/systemd/system/getty@tty1.service.d"
	"${SUDO_CMD}" mkdir -p "${AUTOLOGIN_DIR}"

	AUTOLOGIN_CONF="${AUTOLOGIN_DIR}/autologin.conf"
	"${SUDO_CMD}" tee "${AUTOLOGIN_CONF}" >/dev/null <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\\u' --noclear --autologin ${USERNAME} %I \$TERM
EOF
fi

echo "Installation finished!"
