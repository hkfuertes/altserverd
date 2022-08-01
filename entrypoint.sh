#!/bin/bash

rm -rf /run/avahi-daemon//pid
/etc/init.d/avahi-daemon start
usbmuxd -s &
./netmuxd &>/dev/null &
/bin/bash
