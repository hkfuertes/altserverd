#!/bin/bash

rm -rf /run/avahi-daemon//pid
/etc/init.d/avahi-daemon start
usbmuxd &
./bin/netmuxd &>/dev/null &
./bin/altserver
