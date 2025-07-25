#!/bin/bash

# Kill any existing keyring daemons
killall gnome-keyring-daemon 2>/dev/null

# Start gnome-keyring-daemon
eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID
