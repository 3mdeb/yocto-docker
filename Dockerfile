FROM debian:jessie
MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

RUN apt-get clean && apt-get update && apt-get install -y \
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
    libsdl1.2-dev \
    cpio \
    gcc \
    g++ \
    python3 \
    libssl-dev

RUN useradd -ms /bin/bash build && \
    usermod -aG sudo build

USER build
WORKDIR /home/build
