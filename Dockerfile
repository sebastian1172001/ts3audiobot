FROM ubuntu:latest

MAINTAINER Sebastian U. admin@zuchtbude.de

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir /mnt/server && \
	cd /mnt/server && \
    apt update && \
    apt upgrade -y && \
    apt install -y curl unzip gnupg ca-certificates libopus-dev python-pip ffmpeg  && \
  	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
  	echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
	apt-get update && \
	apt-get install ca-certificates-mono mono-devel mono-complete -y && \
	mono --version && \
	curl -L https://splamy.de/api/nightly/ts3ab/develop/download -o /mnt/server/bot.zip && \
	unzip /mnt/server/bot.zip && \
    useradd -d /home/container -m container

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
