#!/bin/bash
# Author of the script : powen
# Edited by: hkfuertes

sudo echo "[i] Superused cached!"
mkdir -p bin

# Check source and permission
cd "$(dirname "$0")" || exit
echo "[i] Checking source"
if [[ ! -e "./bin/AltStore.ipa" ]]; then
    echo "[i] Downloading AltStore.ipa"
    curl -# -L https://cdn.altstore.io/file/altstore/apps/altstore/1_4_9.ipa > ./bin/AltStore.ipa
    echo "[i] AltStore.ipa Downloaded!"
    echo
fi
if [[ ! -e "bin/netmuxd" ]]; then
    echo "[i] Building netmuxd"
    docker-compose up netmuxd
    echo "[i] netmuxd built!"
    echo
fi
if [[ ! -e "bin/AltServer" ]]; then
    echo "[i] Downloading AltServer"
    curl -# -L https://github.com/NyaMisty/AltServer-Linux/releases/download/v0.0.5/AltServer-`arch` > ./bin/AltServer
    echo "[i] AltServer Downloaded!"
    echo
fi
if [[ "stat ./bin/AltServer | grep -- '-rw-r--r--'" != "" ]] ; then
    chmod +x ./bin/AltServer
fi
if [[ "stat ./bin/netmuxd | grep -- '-rw-r--r--'" != "" ]] ; then
    sudo chmod +x ./bin/netmuxd
fi
if [[ ! -e "AltServer.service" ]] ; then
    sed 's@<path>@'"$PWD"'@' ./services/AltServer.service.dist > ./bin/AltServer.service
    echo "[i] Altserver service file created, link it to systemd to enable|start|stop it!"
    echo
fi
if [[ ! -e "netmuxd.service" ]] ; then
    sed 's@<path>@'"$PWD"'@' ./services/netmuxd.service.dist > ./bin/netmuxd.service
    echo "[i] netmux service file created, link it to systemd to enable|start|stop it!"
    echo
fi

# sudo ln -s `pwd`/bin/AltServer.service /lib/systemd/system/AltServer.service
# sudo ln -s `pwd`/bin/netmuxd.service /lib/systemd/system/netmuxd.service 

echo "[i] All Tasks done!"
