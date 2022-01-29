#!/bin/bash

ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf
echo "computer" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 computer.localdomain computer" >> /etc/hosts

# replace <PASSWORD> with chosen password
echo root:<PASSWORD> | chpasswd

pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers xdg-user-dirs xdg-utils gvfs bash-completion rsync reflector acpi acpi_call acpid upower openbsd-netcat iptables-nft ipset firewalld flatpak os-prober ntfs-3g

pacman -S nvidia xf86-video-intel nvidia-settings nvidia-utils

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable fstrim.timer
systemctl enable firewalld

# Create user annie
useradd -m annie

# replace <PASSWORD> with chosen password
echo annie:<PASSWORD> | chpasswd
usermod -aG wheel annie

# change permissions for wheel group
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
# fan permissions with MSI computer
echo "ALL ALL=(ALL) NOPASSWD: /bin/isw" >> /etc/sudoers
echo "ALL ALL=(ALL) NOPASSWD: /usr/bin/isw" >> /etc/sudoers
echo "ALL ALL=(ALL) NOPASSWD: /bin/silence-fan" >> /etc/sudoers
