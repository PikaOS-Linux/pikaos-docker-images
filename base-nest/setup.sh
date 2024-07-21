#! /bin/bash

set -e

mkdir -p /etc/apt/sources.list.d

rm -rf /etc/apt/sources.list.d/*

### To be replaced with pika-sources wget: Start

# Clear /etc/apt/sources.list in favor of deb822 formats
tee /etc/apt/sources.list <<'EOF'
## This file is deprecated in PikaOS.
## See /etc/apt/sources.list.d/system.sources.
EOF

# Add Pika Repos
tee /etc/apt/sources.list.d/system.sources <<'EOF'
X-Repolib-Name: PikaOS System Sources
Enabled: yes
Types: deb
URIs: https://ppa.pika-os.com/
Suites: pika
Components: nest raven parrot cockatiel pigeon
X-Repolib-ID: system
X-Repolib-Default-Mirror: https://ppa.pika-os.com/
Signed-By: /etc/apt/keyrings/pika-keyring.gpg.key
EOF

# Get keyrings
mkdir -p /etc/apt/keyrings/
wget https://github.com/PikaOS-Linux/pika-base-debian-container/raw/main/pika-keyring.gpg.key -O /etc/apt/keyrings/pika-keyring.gpg.key

### To be replaced with pika-sources wget: End

apt-get update -y

mkdir -p ./deb-folder && cd ./deb-folder
for pkg in $(dpkg --get-selections | cut -f1)
do
    DEBIAN_FRONTEND=noninteractive apt download $pkg -y
done
DEBIAN_FRONTEND=noninteractive apt install -y ./*.deb --allow-downgrades --allow-change-held-packages -o Dpkg::Options::="--force-confnew"
cd ../ && rm -rf ./deb-folder

ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata -o Dpkg::Options::="--force-confnew"

apt-get update -y
DEBIAN_FRONTEND=noninteractive apt full-upgrade -y -o Dpkg::Options::="--force-confnew"