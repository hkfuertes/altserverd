FROM ubuntu
# https://www.apkmirror.com/apk/apple/apple-music/apple-music-3-10-1-release/apple-music-3-10-1-android-apk-download/ (lib folder from inside the apk)

WORKDIR /app

RUN apt-get update && apt-get install -y ninja-build pkg-config git build-essential wget libssl-dev dub libplist-dev curl cmake ldc libimobiledevice-dev

RUN git clone https://github.com/Dadoum/Provision --recursive .
RUN mkdir build && cd build && cmake -G Ninja .. -DCMAKE_BUILD_TYPE=Release -Dbuild_sideloadipa=OFF && ninja

WORKDIR /app/build

COPY libs.tar.gz .

RUN tar -xvzf libs.tar.gz

ENTRYPOINT [ "./anisette_server" ]