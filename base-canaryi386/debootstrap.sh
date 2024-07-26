#! /bin/bash
set -e
DIST=sid ARCH=i386 debootstrap --arch=i386 sid base_chroot || true
rm -rf base_chroot/debootstrap
chroot ./base_chroot /bin/dash -c "DEBIAN_FRONTEND=noninteractive apt-get -y update"
chroot ./base_chroot /bin/dash -c "DEBIAN_FRONTEND=noninteractive apt --fix-broken install -y"
chroot ./base_chroot /bin/dash -c "ln -sfv /bin/dash /bin/sh"
cd  ./base_chroot
sudo tar -czvf ../base_chroot.tgz ./*
