FROM rust AS netmuxd

WORKDIR /netmuxd

RUN git clone https://github.com/jkcoxson/netmuxd .

RUN sed -i 's/, path = "..\/zeroconf-rs\/zeroconf", optional = true//g' Cargo.toml
RUN sed -i 's/, path = "..\/mdns"//g' Cargo.toml

RUN apt-get update && apt-get install -y libavahi-compat-libdnssd-dev libclang-dev

RUN cargo build
#####################################
FROM alpine:3.15 AS altserver

# Preparing Alpine
RUN  apk add zsh git curl wget g++ clang boost-static ninja boost-dev cmake make sudo bash vim libressl-dev util-linux-dev zlib-dev zlib-static

RUN mkdir /buildenv
WORKDIR /buildenv

# Build corecrypto
RUN curl -JO 'https://developer.apple.com/file/?file=security&agree=Yes' -H 'Referer: https://developer.apple.com/security/' && unzip corecrypto.zip
WORKDIR /buildenv/corecrypto

# Needed for script-coverage (Line 29 of corecrypto cmake)
RUN git clone https://github.com/StableCoder/cmake-scripts scripts
RUN mkdir build; cd build; CC=clang CXX=clang++ cmake ..;
WORKDIR /buildenv/corecrypto/build
RUN sed -i -E 's|^(all: CMakeFiles\/corecrypto_perf)|#\1|' CMakeFiles/Makefile2; sed -i -E 's|^(all: CMakeFiles\/corecrypto_test)|#\1|' CMakeFiles/Makefile2
RUN make; make install

# Build c++ rest sdk
WORKDIR /buildenv/cpprestsdk
RUN git clone --recursive https://github.com/microsoft/cpprestsdk .; 
RUN sed -i 's|-Wcast-align||' "./Release/CMakeLists.txt"
RUN mkdir build; cd build; cmake -DBUILD_SHARED_LIBS=0 ..; make; make install

# Build libzip
WORKDIR /buildenv
RUN git clone https://github.com/nih-at/libzip && cd libzip; mkdir build; cd build; cmake -DBUILD_SHARED_LIBS=0 ..; make -j6; make install

# Build altserver
WORKDIR /buildenv/altserver
RUN git clone --recursive https://github.com/NyaMisty/AltServer-Linux .
RUN mkdir build && make && mv ./AltServer-`arch` ./altserver
#####################################
FROM ubuntu

WORKDIR /app

RUN apt-get update -yy && \
    apt-get install -yy \
        avahi-daemon avahi-discover avahi-utils libnss-mdns \
        iputils-ping dnsutils

RUN sed -i 's/.*enable-dbus=.*/enable-dbus=no/' /etc/avahi/avahi-daemon.conf

RUN apt-get update && apt-get install -y usbmuxd curl usbutils iproute2 libimobiledevice-utils libavahi-compat-libdnssd-dev

# Download 'some' AltStore
RUN curl -L https://cdn.altstore.io/file/altstore/apps/altstore/1_4_9.ipa > AltStore.ipa

# Copy from build stage altserver
COPY --from=altserver /buildenv/altserver/altserver .
RUN chmod +x altserver

# Copy from build stage netmuxd
COPY --from=netmuxd /netmuxd/target/debug/netmuxd .
RUN chmod +x netmuxd

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
