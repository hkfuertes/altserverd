FROM rust AS netmuxd

WORKDIR /netmuxd

RUN git clone https://github.com/jkcoxson/netmuxd .

RUN sed -i 's/, path = "..\/zeroconf-rs\/zeroconf", optional = true//g' Cargo.toml
RUN sed -i 's/, path = "..\/mdns"//g' Cargo.toml

RUN apt-get update && apt-get install -y libavahi-compat-libdnssd-dev libclang-dev

RUN cargo build


#####################################
FROM ubuntu

WORKDIR /app

RUN apt-get update -yy && \
    apt-get install -yy \
        avahi-daemon avahi-discover avahi-utils libnss-mdns \
        iputils-ping dnsutils

RUN apt-get update && apt-get install -y usbmuxd curl usbutils iproute2 libimobiledevice-utils libavahi-compat-libdnssd-dev dbus wget

RUN sed -i 's/.*enable-dbus=.*/enable-dbus=no/' /etc/avahi/avahi-daemon.conf

# # workaround to get dbus working, required for avahi to talk to dbus. This will be mounted
# RUN mkdir -p /var/run/dbus
# VOLUME /var/run/dbus

# # Start dBus
# #RUN rm -rf /var/run/dbus/pid
# RUN /etc/init.d/dbus start

# Avahi start daemon
#RUN rm -rf /run/avahi-daemon//pid
#RUN /etc/init.d/avahi-daemon start

# Download 'some' AltStore
RUN curl -L https://cdn.altstore.io/file/altstore/apps/altstore/1_4_9.ipa > AltStore.ipa

# Download AltServer
# TODO: Compile instead...
RUN curl -L https://github.com/NyaMisty/AltServer-Linux/releases/download/v0.0.5/AltServer-`arch` > AltServer
RUN chmod +x AltServer

# Copy from build stage netmuxd
COPY --from=netmuxd /netmuxd/target/debug/netmuxd .
RUN chmod +x netmuxd

RUN wget https://github.com/jkcoxson/netmuxd/releases/download/v0.1.2/netmuxd-x86_64

RUN avahi-daemon &>avahi.log &
RUN usbmuxd &

ENV USBMUXD_SOCKET_ADDRESS=127.0.0.1:27015
RUN ./netmuxd --disable-unix --host 127.0.0.1 &

ENTRYPOINT [ "bash" ]


# docker build -t altserver .
# sudo docker run \
#     --privileged \
#     --network host \
#     -v /dev/bus/usb:/dev/bus/usb \
#     -v /var/lib/lockdown:/var/lib/lockdown \
#     -v /var/run:/var/run \
#     -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
#     -it altserver $@