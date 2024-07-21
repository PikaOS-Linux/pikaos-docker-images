FROM debian:sid
RUN apt update
RUN apt install -y wget ca-certificates apt-utils
RUN wget https://github.com/PikaOS-Linux/docker-pika-canary-base/raw/main/setup.sh
RUN chmod +x ./setup.sh
RUN ./setup.sh