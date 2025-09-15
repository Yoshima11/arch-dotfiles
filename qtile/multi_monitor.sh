#!/bin/bash
NUM_MONIT=$(/bin/xrandr | /bin/grep " connected " | wc -l)
if [[ $NUM_MONIT = 1 ]]; then
/bin/autoranr un_monitor
elif [[ $NUM_MONIT = 2 ]]; then
/bin/autorandr dos_monitor
fi
