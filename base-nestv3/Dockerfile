FROM debian:sid
RUN apt update
RUN apt install -y wget ca-certificates apt-utils
RUN wget https://github.com/PikaOS-Linux/pikaos-docker-images/raw/main/base-canaryv3/setup.sh
RUN chmod +x ./setup.sh
RUN ./setup.sh
RUN rm -fv ./setup.sh