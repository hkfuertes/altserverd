FROM alpine

WORKDIR /app

RUN apk add zsh git curl wget g++ clang boost-static ninja boost-dev cmake make sudo bash vim libressl-dev util-linux-dev zlib-dev zlib-static



#   1. Run alpine docker (change --platform to corresponding architecture you want): 
#       docker run --platform=linux/arm/v7 --name altserver-builder-alpine-armv7 -it alpine:3.15 
#   2. Install dependencies:
#       apk add zsh git curl wget g++ clang boost-static ninja boost-dev cmake make sudo bash vim libressl-dev util-linux-dev zlib-dev zlib-static
#   3. Install corecrypto
#       download corecrypto from apple website, unzip corecrypto.zip; cd corecrypto; mkdir build; cd build; CC=clang CXX=clang++ cmake ..;
#       vim CMakeFiles/Makefile2, delete line starts with "all: corecrypto_perf/....." and "all: corecrypto_test/.....", then make; make install
#   4. Install cpprestsdk
#       git clone --recursive https://github.com/microsoft/cpprestsdk; cd cpprestsdk; mkdir build; cmake -DBUILD_SHARED_LIBS=0 ..; make; make install
#       (if you're compiling for armv7, you have to grep -Wcast-align, and remove it, or the compiling would fail)
#   5. Install libzip
#       git clone https://github.com/nih-at/libzip; cd libzip; mkdir build; cd build; cmake -DBUILD_SHARED_LIBS=0 ..; make; make install
#   6. Compile AltServer-Linux
#       git clone --recursive https://github.com/NyaMisty/AltServer-Linux
#       cd AltServer-Linux
#       make -f ../Makefile -j3
#       (if you're compiling for ARM, i.e. armv7 or aarch64, you'll have to remove the -mno-default flag in Makefile)


