#!/bin/sh

# Intended to be ran as SUDO from /
# Have Dotfiles folder cloned to ~/ before running script
# Not to be run until post-install-script.sh has been run first


## This installer script:
##		* sets up sudo configurations

cp -r /home/annie/Dotfiles/root/bin/* /bin/
cp -r /home/annie/Dotfiles/root/etc/environment /etc/
cp -r /home/annie/Dotfiles/root/etc/isw.conf /etc/
cp -r /home/annie/Dotfiles/root/etc/default/zramd /etc/default/zramd
cp -r /home/annie/Dotfiles/root/etc/systemd/system/* /etc/systemd/system/
cp -r /home/annie/Dotfiles/root/usr/share/themes/Vault /usr/share/themes/
cp -r /home/annie/Dotfiles/root/etc/xdg/reflector/reflector.conf /etc/xdg/reflector/

chmod +x /bin/newsboat-fix
chmod +x /bin/silence-fan

systemctl enable --now auto-cpufreq
systemctl enable optimus-manager
systemctl enable lightdm
systemctl enable --now zramd
systemctl enable --now thermald
systemctl enable slock@annie.service
systemctl enable resume-fan.service
systemctl enable reflector.service
