#!/bin/bash

# Colors (adjust to match your polybar theme)
COLOR_ENABLED="#89b4fa"
COLOR_DISABLED="#45475a"
COLOR_CONNECTED="#a6e3a1"

# Icons (you can use Font Awesome or similar)
ICON_ON="󰂯"
ICON_OFF="󰂲"
ICON_CONNECTED="󰂱"

# Check if bluetooth is enabled
bluetooth_status=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

if [[ "$bluetooth_status" == "yes" ]]; then
    # Get connected devices
    connected_devices=$(bluetoothctl devices Connected | cut -d' ' -f2-)
    device_count=$(echo "$connected_devices" | wc -l)
    
    if [[ -n "$connected_devices" && "$connected_devices" != "" ]]; then
        # Has connected devices - just show connected icon
        echo "%{F$COLOR_CONNECTED}$ICON_CONNECTED%{F-}"
        
        # Tooltip with connected devices
        tooltip="Connected devices:\n"
        while IFS= read -r device; do
            if [[ -n "$device" ]]; then
                device_name=$(echo "$device" | cut -d' ' -f2-)
                tooltip="$tooltip• $device_name\n"
            fi
        done <<< "$connected_devices"
        
        # Remove last newline and set tooltip
        tooltip=$(echo -e "${tooltip%\\n}")
        echo "$tooltip" > /tmp/polybar_bluetooth_tooltip
    else
        # Bluetooth on but no devices connected
        echo "%{F$COLOR_ENABLED}$ICON_ON%{F-}"
        echo "Bluetooth: ON (No devices connected)" > /tmp/polybar_bluetooth_tooltip
    fi
else
    # Bluetooth disabled
    echo "%{F$COLOR_DISABLED}$ICON_OFF%{F-}"
    echo "Bluetooth: OFF" > /tmp/polybar_bluetooth_tooltip
fi
