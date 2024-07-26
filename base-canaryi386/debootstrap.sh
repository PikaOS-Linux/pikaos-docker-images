#! /bin/bash
set -e
# Run at 07/08/2023 19:40 UTC 3
DIST=sid ARCH=i386 debootstrap --arch=i386 sid base_chroot || true
rm -rf base_chroot/debootstrap
cd  ./base_chroot
sudo tar -czvf ../base_chroot.tgz ./*
