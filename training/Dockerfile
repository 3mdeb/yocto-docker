FROM 3mdeb/yocto-docker:2.0.0

MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    autopoint \
    cmake \
    flex \
    gettext \
    libtool \
    man \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
