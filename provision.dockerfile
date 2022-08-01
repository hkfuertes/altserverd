# Provision Build Dockerfile
# https://github.com/Dadoum/Provision
#
# docker build -t provision - < provison.dockerfile
# docker run -p 6969:6969 -v /path/to/lib:/app/build/lib provision
#
# "lib" folder can be found in android's Apple Music APK.
# https://www.apkmirror.com/apk/apple/apple-music/apple-music-3-10-1-release/apple-music-3-10-1-android-apk-download/ 
# Extract the APK and bind mount it in /app/build/lib
# According to author, just `libstoreservicescore.so` and `libCoreADI.so` are needed, everything else can be removed. 

FROM ubuntu

WORKDIR /app

RUN apt-get update && apt-get install -y ninja-build pkg-config git build-essential wget libssl-dev dub libplist-dev curl cmake ldc libimobiledevice-dev

RUN git clone https://github.com/Dadoum/Provision --recursive .
RUN mkdir build && cd build && cmake -G Ninja .. -DCMAKE_BUILD_TYPE=Release -Dbuild_sideloadipa=OFF && ninja

WORKDIR /app/build

ENTRYPOINT [ "./anisette_server" ]