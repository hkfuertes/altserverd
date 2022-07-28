#!/bin/bash

if [[ ! -f /build/netmuxd ]] 
then
    cargo build
    cp target/debug/netmuxd /build/
fi