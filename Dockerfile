FROM ubuntu
# https://www.apkmirror.com/apk/apple/apple-music/apple-music-3-10-1-release/apple-music-3-10-1-android-apk-download/ (lib folder from inside the apk)
WORKDIR /app

RUN apt-get update && apt-get install -y libavahi-compat-libdnssd-dev wget usbmuxd

# Download altserver
RUN wget https://github.com/NyaMisty/AltServer-Linux/releases/download/v0.0.5/AltServer-`uname -m` -O altserver
RUN chmod +x ./altserver

# Copy netmuxd
COPY --from=netmuxd /app/target/debug/netmuxd netmuxd

#ENTRYPOINT [ "./altserver" ]