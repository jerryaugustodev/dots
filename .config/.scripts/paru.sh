#!/bin/bash

{
	echo -e "Let's install PARU. We can proceed? (y/N)?"
	read -r answer
	if [[ $answer = [sSyY] ]]; then
		echo -e "\nInstalling...\n"

		sudo pacman -S --noconfirm --needed base-devel
		sudo pacman -S --noconfirm --needed git
		sudo pacman -S --noconfirm --needed rust
		sleep 1

		git clone https://aur.archlinux.org/paru-bin.git
		sleep 0.5
		cd paru || exit
		sleep 0.5
		makepkg -si

	else
		quit
	fi
}

quit() {
	echo -e "\nGoing out...\n"
	exit 0
}
