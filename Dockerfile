FROM ubuntu:20.04

LABEL maintainer="Piotr Król <piotr.krol@3mdeb.com>"
LABEL release="kirkstone"

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

# Install packages listed in Yocto documentation as esential
RUN apt-get update && apt-get install -y \
    gawk \
    wget \
    git \
    diffstat \
    unzip \
    texinfo \
    gcc \
    build-essential \
    chrpath \
    socat \
    cpio \
    python3 \
    python3-pip \
    python3-pexpect \
    xz-utils \
    debianutils \
    iputils-ping \
    python3-git \
    python3-jinja2 \
    libegl1-mesa \
    libsdl1.2-dev \
    xterm \
    python3-subunit \
    mesa-common-dev \
    zstd \
    liblz4-tool && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install GitPython pylint

# Install packages added by 3mdeb
RUN apt-get update && apt-get install -y \
    bc \
    dos2unix \
    fop \
    g++-multilib \
    gcc-multilib \
    git-lfs \
    libncurses5-dev \
    python3-dev \
    python2.7-dev \
    python-is-python2 \
    tmux \
    vim \
    xsltproc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install and update ca-certificates
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    update-ca-certificates

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

RUN git lfs install
