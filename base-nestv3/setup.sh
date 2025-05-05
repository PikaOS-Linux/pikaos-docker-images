#! /bin/bash

set -e
apt update -y
apt install curl gpg -y
mkdir -p /etc/apt/sources.list.d

rm -rf /etc/apt/sources.list.d/*

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
curl -s https://ppa.pika-os.com/key.gpg | gpg --dearmor > /etc/apt/keyrings/pika-keyring.gpg.key

# Setup apt configration
mkdir -p /etc/apt/preferences.d/
tee /etc/apt/preferences.d/0-pika-nest-settings <<'EOF'
Package: *
Pin: release a=pika,c=nest
Pin-Priority: 1001
EOF

apt-get update -y

apt-mark hold pika-baseos

dpkg --get-selections | cut -f1 > ./installed.txt
for pkg in $(cat ./installed.txt)
do
    [ "$pkg" = "resolvconf" ] && echo "Skipping resolvconf..." && continue
    DEBIAN_FRONTEND=noninteractive apt install -y $pkg --allow-downgrades -o Dpkg::Options::="--force-confnew"
done

rm -fv ./installed.txt

rm -fv /etc/apt/preferences.d/0-pika-nest-settings
#

ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata pika-sources -o Dpkg::Options::="--force-confnew"

apt-get update -y
DEBIAN_FRONTEND=noninteractive apt full-upgrade -y -o Dpkg::Options::="--force-confnew"

apt-mark unhold pika-baseos
