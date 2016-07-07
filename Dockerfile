FROM debian:jessie
MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

RUN apt-get update && apt-get install -y \
    gawk \
    wget \
    git-core \
    diffstat \
    unzip \
    texinfo \
    gcc-multilib \
    build-essential \
    chrpath \
    socat \
    libsdl1.2-dev

RUN useradd -ms /bin/bash build && \
    usermod -aG sudo build

USER build
WORKDIR /home/build
