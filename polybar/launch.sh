#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log /tmp/polybar3.log 


polybar -c ~/.files/polybar/paracorde base >>/tmp/polybar1.log 2>&1 &
polybar -c ~/.files/polybar/paracorde workspaces >>/tmp/polybar3.log 2>&1 &
polybar -c ~/.files/polybar/paracorde info >>/tmp/polybar2.log 2>&1 &
#polybar -c ~/.config/polybar/daft bottom >>/tmp/polybar2.log 2>&1 &
#polybar -c ~/.config/polybar/daft external >>/tmp/polybar3.log 2>&1 &

echo "Bars launched..."
