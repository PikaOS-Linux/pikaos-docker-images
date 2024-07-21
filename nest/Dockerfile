FROM debian:sid
RUN apt update
RUN apt install -y wget ca-certificates apt-utils
RUN wget https://github.com/PikaOS-Linux/docker-pikaos-base/raw/main/nest/setup.sh
RUN chmod +x ./setup.sh
RUN ./setup.sh