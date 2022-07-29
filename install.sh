#!/bin/bash
# Author of the script : powen
# Edited by: hkfuertes

sudo echo "[i] Superused cached!"

# Check source and permission
cd "$(dirname "$0")" || exit
echo "[i] Checking source"
if [[ ! -e "AltStore.ipa" ]]; then
    echo "[i] Downloading AltStore.ipa"
    curl -# -L https://cdn.altstore.io/file/altstore/apps/altstore/1_4_9.ipa > AltStore.ipa
    echo "[i] AltStore.ipa Downloaded!"
    echo
fi
if [[ ! -e "netmuxd" ]]; then
    echo "[i] Building netmuxd"
    docker-compose up netmuxd
    echo "[i] netmuxd built!"
    echo
fi
if [[ ! -e "AltServer" ]]; then
    echo "[i] Downloading AltServer"
    curl -# -L https://github.com/NyaMisty/AltServer-Linux/releases/download/v0.0.5/AltServer-`arch` > AltServer
    echo "[i] AltServer Downloaded!"
    echo
fi
if [[ "stat AltServer | grep -- '-rw-r--r--'" != "" ]] ; then
    chmod +x AltServer
fi
if [[ "stat netmuxd | grep -- '-rw-r--r--'" != "" ]] ; then
    sudo chmod +x netmuxd
fi
if [[ ! -e "AltServer.service" ]] ; then
    sed 's@<path>@'"$PWD"'@' AltServer.service.dist > AltServer.service
    echo "[i] Altserver service file created, link it to systemd to enable|start|stop it!"
    echo
fi
if [[ ! -e "netmuxd.service" ]] ; then
    sed 's@<path>@'"$PWD"'@' netmuxd.service.dist > netmuxd.service
    echo "[i] netmux service file created, link it to systemd to enable|start|stop it!"
    echo
fi

echo "[i] All Tasks done!"
