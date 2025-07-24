#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar
echo "---" | tee -a /tmp/polybar1.log
polybar main 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Polybar launched..."
