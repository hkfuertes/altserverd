#!/bin/bash

if [ "$CONFIG" = true ]
then  
    /bin/bash
else
    rm -rf /run/avahi-daemon//pid
    /etc/init.d/avahi-daemon start
    usbmuxd &
    ./netmuxd &>/dev/null &
    ./AltServer
fi