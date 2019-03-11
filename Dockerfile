FROM debian:stretch

# Install required system packages
RUN apt-get update && apt-get install -y \
    apt-utils \
    automake \
    g++ \
    make \
    libtool \
    pkg-config \
    doxygen \
    libdb++-dev \
    curl \
    bsdmainutils \
    libboost-all-dev \
    libssl-dev \
    libevent-dev

# Install Berkeley DB 4.8
RUN curl -L http://download.oracle.com/berkeley-db/db-4.8.30.tar.gz | tar -xz -C /tmp && \
    cd /tmp/db-4.8.30/build_unix && \
    ../dist/configure --enable-cxx --includedir=/usr/include/bdb4.8 --libdir=/usr/lib && \
    make -j$(nproc) && make install && \
    cd / && rm -rf /tmp/db-4.8.30

RUN useradd -mU PALLY1

COPY . /tmp/PALLY1core/

RUN cd /tmp/PALLY1core && \
    ./autogen.sh && \
    ./configure --without-gui --prefix=/usr && \
    make -j$(nproc) && \
    make check && \
    make install && \
    cd / && rm -rf /tmp/PALLY1core

# Remove unused packages
RUN apt-get remove -y \
    automake \
    g++ \
    make \
    libtool \
    pkg-config \
    doxygen \
    libdb++-dev \
    curl \
    bsdmainutils \
    libboost-all-dev \
    libssl-dev \
    libevent-dev

USER PALLY1:PALLY1

RUN mkdir /home/PALLY1/.PALLY1core && \
    touch /home/PALLY1/.PALLY1core/PALLY1.conf

VOLUME [ "/home/PALLY1/.PALLY1core" ]

EXPOSE 65530
EXPOSE 8332
EXPOSE 18332

ENTRYPOINT ["/usr/bin/PALLY1d", "--conf=/home/PALLY1/.PALLY1core/PALLY1.conf"]
