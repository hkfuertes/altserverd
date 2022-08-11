FROM rust

WORKDIR /app

RUN git clone https://github.com/jkcoxson/netmuxd .
# Working commit
RUN git checkout 315131a271961721189dd228bddfa863ba6376d2

RUN sed -i 's/, path = "..\/zeroconf-rs\/zeroconf", optional = true//g' Cargo.toml
RUN sed -i 's/, path = "..\/mdns"//g' Cargo.toml

RUN apt-get update && apt-get install -y libavahi-compat-libdnssd-dev libclang-dev
