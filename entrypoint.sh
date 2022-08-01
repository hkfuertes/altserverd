#!/bin/bash

rm -rf /run/avahi-daemon//pid
/etc/init.d/avahi-daemon start
usbmuxd
./netmuxd &>/dev/null &
/bin/bash
