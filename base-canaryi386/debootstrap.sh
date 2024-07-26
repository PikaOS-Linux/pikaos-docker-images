#! /bin/bash
set -e
DIST=sid ARCH=i386 debootstrap --arch=i386 sid base_chroot || true
rm -rf base_chroot/debootstrap
chroot ./base_chroot /bin/bash -c "ln -sfv /bin/dash /bin/sh"
cd  ./base_chroot
sudo tar -czvf ../base_chroot.tgz ./*
