FROM alpine:3.15

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
RUN git clone https://github.com/nih-at/libzip && cd libzip; mkdir build; cd build; cmake -DBUILD_SHARED_LIBS=0 ..; make ; make install

# Build altserver
WORKDIR /buildenv/altserver
RUN git clone --recursive https://github.com/NyaMisty/AltServer-Linux -b v0.0.5 .
# RUN mkdir build && make && mv ./AltServer-* ./altserver
