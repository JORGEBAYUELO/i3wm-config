#!/bin/bash

# Toggle bluetooth on/off
bluetooth_status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

if [[ "$bluetooth_status" == "yes" ]]; then
    bluetoothctl power off
    notify-send "Bluetooth" "Bluetooth disabled" -i bluetooth-disabled
else
    bluetoothctl power on
    notify-send "Bluetooth" "Bluetooth enabled" -i bluetooth-active
fi
