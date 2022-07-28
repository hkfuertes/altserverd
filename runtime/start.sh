#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

./netmuxd --disable-unix --host 127.0.0.1 &
USBMUXD_SOCKET_ADDRESS=127.0.0.1:27015 ./altserver

trap_ctrlc() {
    killall netmuxd
    killall altserver
}

trap trap_ctrlc INT

# wait for all background processes to terminate
wait
