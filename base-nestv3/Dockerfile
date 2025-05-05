FROM debian:sid
RUN apt update
RUN umount -f /etc/resolv.conf
RUN apt install -y wget ca-certificates apt-utils desktop-file-utils linux-base resolvconf
RUN wget https://github.com/PikaOS-Linux/pikaos-docker-images/raw/main/base-nestv3/setup.sh
RUN chmod +x ./setup.sh
RUN ./setup.sh
RUN rm -fv ./setup.sh
