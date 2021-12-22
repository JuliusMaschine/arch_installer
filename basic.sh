#!/bin/bash

locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
pacman -Sy --noconfirm

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

PKGS = {
    'grub'
    'efibootmgr'
    'networkmanager'
    'network-manager-applet' 
    'reflector' 'base-devel' 
    'linux-headers' 
    'xdg-user-dirs' 
    'bluez' 
    'bluez-utils' 
    'alsa-utils' 
    'pipewire' 
    'pipewire-alsa' 
    'pipewire-pulse' 
    'pipewire-jack' 
    'bash-completion' 
    'openssh' 
    'reflector' 
    'iptables-nft'
    'ranger'
    'kitty' 
    'fish' 
    'bspwm'
    'sxhkd'
}

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

pacman -S --noconfirm pacman-contrib
pacman -S --noconfirm reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable bluetooth

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
