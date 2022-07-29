#!/bin/bash
# Author of the script : powen
# Edited by: hkfuertes

CP = `pwd`

# Check source and permission
cd "$(dirname "$0")" || exit
echo "Checking source"
if [[ ! -e "AltStore.ipa" ]]; then
    curl -L https://cdn.altstore.io/file/altstore/apps/altstore/1_4_9.ipa > AltStore.ipa
fi
if [[ ! -e "netmuxd" ]]; then
    docker-compose up netmuxd
fi
if [[ ! -e "Altserver" ]]; then
    curl -L https://github.com/NyaMisty/AltServer-Linux/releases/download/v0.0.5/AltServer-`arch` > Altserver
fi
if [[ "stat AltServer | grep -- '-rw-r--r--'" != "" ]] ; then
    chmod +x AltServer
fi
if [[ "stat netmuxd | grep -- '-rw-r--r--'" != "" ]] ; then
    sudo chmod +x netmuxd
fi
if [[ ! -e "AltServer.service" ]] ; then
    sed 's@<path>@'"$PWD"'@' AltServer.service.dist > AltServer.service
    echo "Altserver service file created, link it to systemd to enable|start|stop it!"
fi
if [[ ! -e "netmuxd.service" ]] ; then
    sed 's@<path>@'"$PWD"'@' netmuxd.service.dist > netmuxd.service
    echo "netmux service file created, link it to systemd to enable|start|stop it!"
fi
