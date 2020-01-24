FROM ubuntu:18.04

MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

# Update the package repository
RUN apt-get update && apt-get install -y \
	locales

# Configure locales
# noninteractive installation using debconf-set-selections does not seem
# to work due to a bug in Debian glibc:
# https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1598326
# RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
#     echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
#     dpkg-reconfigure --frontend=noninteractive locales && \
#     update-locale LANG=en_US.UTF-8
# RUN locale-gen en_US.UTF-8
# ENV LANG en_US.UTF-8
# ENV LANGUAGE en_US:en
# ENV LC_ALL en_US.UTF-8

# Set up the non-interactive container build
ARG DEBIAN_FRONTEND=noninteractive

# Set up locales
RUN apt-get -y install locales apt-utils sudo && \
    dpkg-reconfigure locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.utf8

# Yocto dependencies
RUN apt-get install -y \
    autoconf \
    automake \
    autopoint \
    build-essential \
    chrpath \
    cmake \
    cpio \
    debianutils \
    diffstat \
    flex \
    fop \
    g++-multilib \
    gawk \
    gcc-multilib \
    gettext \
    git-core \
    iputils-ping \
    libegl1-mesa \
    libncurses5-dev \
    libsdl1.2-dev \
    libtool \
    man \
    pylint3 \
    python \
    python-dev \
    python3 \
    python3-dev \
    python3-git \
    python3-jinja2 \
    python3-pexpect \
    python3-pip \
    socat \
    texinfo \
    tmux \
    unzip \
    vim \
    wget \
    xsltproc \
    xterm \
    xz-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install repo tool
RUN wget -O /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo \
    && chmod 755 /usr/local/bin/repo

RUN useradd -ms /bin/bash build && \
    usermod -aG sudo build

RUN useradd -ms /bin/bash -u 500 jenkinsbuilder && \
    usermod -aG sudo jenkinsbuilder

ADD VERSION .

USER build
WORKDIR /home/build
