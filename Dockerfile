FROM ubuntu:18.04

MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

# Set up the non-interactive container build
ARG DEBIAN_FRONTEND=noninteractive

# Set up locales
RUN apt-get update && apt-get install -y \
    apt-utils locales sudo && \
    dpkg-reconfigure locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV LANG en_US.utf8

RUN apt-get update && apt-get install -y \
    build-essential \
    chrpath \
    cpio \
    debianutils \
    diffstat \
    fop \
    g++-multilib \
    gawk \
    gcc-multilib \
    git-core \
    iputils-ping \
    libegl1-mesa \
    libncurses5-dev \
    libsdl1.2-dev \
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
