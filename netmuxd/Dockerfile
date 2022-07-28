FROM rust

WORKDIR /app

RUN git clone https://github.com/jkcoxson/netmuxd .

COPY Cargo.toml .

RUN apt-get update && apt-get install -y libavahi-compat-libdnssd-dev libclang-dev
RUN cargo build

WORKDIR /app/target/debug

#ENTRYPOINT [ "./netmuxd", "--disable-unix", "--host 0.0.0.0" ]
