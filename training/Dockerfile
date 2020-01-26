FROM 3mdeb/yocto-docker:2.0.0

MAINTAINER Piotr Król <piotr.krol@3mdeb.com>

USER root

RUN apt-get update && apt-get install -y \
    rpcbind \
    vinagre \
    iproute2 \
    autoconf \
    automake \
    autopoint \
    cmake \
    flex \
    gettext \
    libtool \
    man \
    meson \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD rpcbind /etc/default/rpcbind

# passwd: build
RUN usermod -p FGFIMIqYYKTBU build
