#!/bin/bash
# Author of the script : powen
# Edited by: hkfuertes

# Check source and permission
cd "$(dirname "$0")" || exit
echo "Checking source"
if [[ ! -e "AltStore.ipa" ]]; then
    curl -L https://cdn.altstore.io/file/altstore/apps/altstore/1_4_9.ipa > AltStore.ipa
fi
if [[ ! -e "netmuxd" ]]; then
    #curl -L https://github.com/jkcoxson/netmuxd/releases/download/v0.1.2/netmuxd-x86_64 > netmuxd
fi
if [[ ! -e "altserver" ]]; then
    curl -L https://github.com/NyaMisty/AltServer-Linux/releases/download/v0.0.5/AltServer-`uname -r` > altserver
fi
if [[ "stat main | grep -- '-rw-r--r--'" != "" ]] ; then
    chmod +x main
fi
if [[ "stat AltServer | grep -- '-rw-r--r--'" != "" ]] ; then
    chmod +x AltServer
fi
if [[ "stat netmuxd | grep -- '-rw-r--r--'" != "" ]] ; then
    chmod +x netmuxd
fi

sudo -b -S ./netmuxd
./AltServer &> /dev/null &


trap exit INT

exit()
{
  echo "Killing AltServer"
  killall AltServer
  echo "Killing netmuxd"
  sudo killall netmuxd
  exit
}
