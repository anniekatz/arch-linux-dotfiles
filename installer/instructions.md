# System Install Instructions

1. Insert and boot from Arch Linux USB

2. Load keymap
	
	> loadkeys us

3. Connect to WiFi using iwctl
	
	> iwctl
	
    > station {STATION} connect {WIFI SSID NAME}
	
    * wifi stations are usualy wlan0, wlo1, etc.

4. Refresh servers
	
	> pacman -Syy
 
	> pacman -S archlinux-keyring 

5. Partition disk (ex. nvme0n1) using fdisk, gdisk or cfdisk
	
    * Warning: manipulating disk may remove data

	
	> cfdisk /dev/nvme0n1
	
	* Disk to be partitioned as:
	
		| Partition             | Size      | Type             |
		|-----------------------|-----------|------------------|
		| nvme0n1p1             | 512 M     | EFI System       |
		| nvme0n1p2             | Over 50 G | Linux filesystem |
		| Free Space/Other OSes |           |                  |
	
		* Remember to leave space at the end of SSD for good practice

6. Make file systems
	
	> mkfs.vfat /dev/nvme0n1p1

	> mkfs.ext4 /dev/nvme0n1p2

7. Mount partitions
	
	> mount /dev/nvme0n1p2 /mnt
	
    > mkdir -p /mnt/boot/efi
	
    > mount /dev/nvme0n1p1 /mnt/boot/efi

8. Install base
	
	> pacstrap /mnt base linux linux-firmware git neovim intel-ucode

9. Generate fstab

	> genfstab -U /mnt >> /mnt/etc/fstab

10. Chroot into install
	
	> arch-chroot /mnt

11. Change fstab file
	* edit /etc/fstab - include the options (noatime,commit=60,discard) in root (/) partition

12. Clone Dotfiles repo
	
	> git clone https://github.com/anniekatz/Dotfiles 

13. Run base install script
	* Edit script first to include usernames, passwords, hostname, etc.

		> chmod +x ./Dotfiles/installer/first-install-script.sh
	
		> ./Dotfiles/installer/first-install-script.sh

	* Follow prompts

14. Move Dotfiles repo if u want
	
	> mv Dotfiles /home/{username}/

15. Exit and reboot
	
	> exit
	
    > umount -a
	
    > reboot

16. Log in as user with username and password

17. Configure WiFi
	
	> nmtui

18. Enable multilib repo
	* Edit /etc/pacman.conf to uncomment [multilib] and following line

	> sudo nvim /etc/pacman.conf
	
19. Refresh and update
	
	> sudo pacman -Syu

20. Run post-install script
	
	> sudo chown -R {username}:users ./Dotfiles/*

	> chmod +x ~/Dotfiles/installer/post-install-script.sh
	
    > ~/Dotfiles/installer/post-install-script.sh
    
    * Important: Install zramd and mullvad-vpn manually after this, as they tend to have issues in installer script

21. Configure grub to work with MSI fan
	
	> sudo nvim /etc/default/grub
	
	* Edit file to include module "ec_sys.write_support=1" in GRUB_CMDLINE_LINUX_DEFAULT line and add the line GRUB_DISABLE_OS_PROBER=false
    * There is also a grub file you can copy over in Dotfiles/root/etc/default you can copy over

	> sudo grub-mkconfig -o /boot/grub/grub.cfg

22. Generate new initramfs
	* Edit /etc/mkinitcpio.conf to include (i915, nvidia, nvidia_drm, nvidia_modeset) in MODULES then regenerate
	
	> sudo mkinitcpio -p linux
	
23. Become super-user and run second post-install script
	
	> sudo su

	> chmod +x ~/Dotfiles/installer/second-post-install-script.sh
	
	> Dotfiles/installer/second-post-install-script.sh

24. Reboot into newly configured system
	
	> sudo reboot

25. Perform other configurations in GUI
	* Use lxappearance, kvantummanager, and qt5ct for changing app theme to fit system theme
	* Configure lightdm-gtk-greeter
	* Use nitrogen to change wallpaper
