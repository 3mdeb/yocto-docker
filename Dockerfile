FROM ubuntu:16.04

MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

# Update the package repository
RUN apt-get update && apt-get upgrade -y && apt-get install locales

# Configure locales
# noninteractive installation using debconf-set-selections does not seem
# to work due to a bug in Debian glibc:
# https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1598326
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Yocto dependencies
RUN apt-get install -y \
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
    python \
    python3 \
    python3-pip \
    python3-pexpect \
    xz-utils \
    debianutils \
    iputils-ping \
    libsdl1.2-dev \
    xterm \
    libssl-dev

RUN useradd -ms /bin/bash build && \
    usermod -aG sudo build

USER build
WORKDIR /home/build
