#!/bin/bash

docker build -t altserver .
sudo docker run \
    --privileged \
    --network host \
    -v /dev/bus/usb:/dev/bus/usb \
    -v /var/lib/lockdown:/var/lib/lockdown \
    -v /var/run:/var/run \
    -it altserver $@