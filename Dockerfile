FROM rust AS stage1

WORKDIR /netmuxd

RUN git clone https://github.com/jkcoxson/netmuxd .

RUN sed -i 's/, path = "..\/zeroconf-rs\/zeroconf", optional = true//g' Cargo.toml
RUN sed -i 's/, path = "..\/mdns"//g' Cargo.toml

RUN apt-get update && apt-get install -y libavahi-compat-libdnssd-dev libclang-dev

#####################################
FROM ubuntu

WORKDIR /app

RUN apt-get update && apt-get install -y libavahi-compat-libdnssd-dev usbmuxd

# Download 'some' AltStore
RUN curl -L https://cdn.altstore.io/file/altstore/apps/altstore/1_4_9.ipa > AltStore.ipa

# Download AltServer
# TODO: Compile instead...
RUN curl -# -L https://github.com/NyaMisty/AltServer-Linux/releases/download/v0.0.5/AltServer-`arch` > AltServer
RUN chmod +x AltServer

# Copy from built stage netmuxd
COPY --from=stage1 /netmuxd/target/debug/netmuxd .
RUN chmod +x netmuxd

# RUN ./netmuxd &>/dev/null &

ENTRYPOINT [ "AltServer" ]