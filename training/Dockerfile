FROM 3mdeb/yocto-docker:2.3.5

LABEL maintainer="Piotr Król <piotr.krol@3mdeb.com>"
LABEL release="kirkstone"

USER root

RUN apt-get update && apt-get install -y \
    rpcbind \
    vinagre \
    iproute2 \
    autoconf \
    automake \
    autopoint \
    cmake \
    graphviz \
    flex \
    gettext \
    libgtk-3-dev \
    libtool \
    man \
    meson && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD rpcbind /etc/default/rpcbind

# passwd: build
RUN usermod -p FGFIMIqYYKTBU build
