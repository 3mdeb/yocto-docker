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
    libgtk-3-dev \
    libtool \
    man \
    meson \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add Toaster python packages
RUN pip3 install 'Django>1.8,<1.12' \
    'beautifulsoup4>=4.4.0' \
    'python-Levenshtein==0.12.0' \
    pytz

ADD rpcbind /etc/default/rpcbind

# passwd: build
RUN usermod -p FGFIMIqYYKTBU build
