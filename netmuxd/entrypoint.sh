#!/bin/bash

if [ ! -f /build/netmuxd ]
    cargo build
    cp target/debug/netmuxd /build/
fi