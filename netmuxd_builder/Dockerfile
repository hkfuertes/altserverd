FROM rust

WORKDIR /app

RUN git clone https://github.com/jkcoxson/netmuxd .

COPY Cargo.toml .

RUN apt-get update && apt-get install -y libavahi-compat-libdnssd-dev libclang-dev

COPY entrypoint.sh .
RUN chmod +x ./entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
