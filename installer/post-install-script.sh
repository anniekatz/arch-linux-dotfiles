#!/bin/sh

# Intended to be ran as user from ~/
# Have Dotfiles folder cloned to ~/ before running script
# Not to be run until base-install.sh has been run first


## This installer script:
##		* installs yay package manager
##		* uses yay to install all packages
##		* sets up some configurations for my system
##		* sets up user system services necessary for my system


# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

sleep 3

# Install all packages
yay -Syu - < ~/Dotfiles/installer/installed-packages/packages-for-script.txt

sleep 3

mkdir .local/bin

cp -r ~/Dotfiles/home/.local/bin/* ~/.local/bin/
cp -r ~/Dotfiles/home/.config/autostart ~/.config/
cp -r ~/Dotfiles/home/.config/dunst ~/.config/
cp -r ~/Dotfiles/home/.config/kitty ~/.config/
cp -r ~/Dotfiles/home/.config/qtile ~/.config/
cp -r ~/Dotfiles/home/.config/neofetch ~/.config/
cp -r ~/Dotfiles/home/.config/newsboat ~/.config/
cp -r ~/Dotfiles/home/.config/nvim ~/.config/
cp -r ~/Dotfiles/home/.config/nwg-launchers ~/.config/
cp -r ~/Dotfiles/home/.config/picom ~/.config/
cp -r ~/Dotfiles/home/.config/qutebrowser ~/.config/
cp -r ~/Dotfiles/home/.config/ranger ~/.config/
cp -r ~/Dotfiles/home/.config/volumeicon ~/.config/
cp -r ~/Dotfiles/home/.config/rofi ~/.config/
cp -r ~/Dotfiles/home/.config/redshift ~/.config/
cp -r ~/Dotfiles/home/.bashrc ~/
cp -r ~/Dotfiles/home/.xprofile ~/
cp -r ~/Dotfiles/home/wallpapers ~/Pictures/
cp -r ~/Dotfiles/home/.config/nitrogen ~/.config/

chmod +x ~/.local/bin/list-keybindings
chmod +x ~/.local/bin/newsboat-fix
chmod +x ~/.xprofile
chmod +x ~/.config/qtile/autostart.sh
chmod +x ~/.config/rofi/powermenu/powermenu.sh
chmod +x ~/.config/rofi/launchers/misc/launcher.sh
chmod +x ~/.config/rofi/launchers/colorful/launcher.sh


systemctl --user enable pipewire
systemctl --user enable pipewire-pulse
systemctl --user enable wireplumber
systemctl --user enable redshift
