#!/bin/bash
#
# Check every minute for shutdown in case of power failure and low battery level
#

BATTERY_WARN="$1"
BATTERY_SHUTDOWN="$2"
SHUTDOWN_DELAY="$3"

# infinite loop
while true; do

    # Example output from acpi --battery
    # Battery 0: Discharging, 88%, 03:13:24 remaining
    # Battery 0: Charging, 87%, 00:25:53 until charged

    # Get the battery status line indicating the discharging condition.
    BATTERY_CAPACITY="`acpi --battery | grep Discharging | sed 's/.*, \([0-9]\+\)%.*/\1/g'`"

    # If battery is in discharging state.
    if [ -n "$BATTERY_CAPACITY" ]; then
        if [ "$BATTERY_CAPACITY" -lt "$BATTERY_SHUTDOWN" ]; then
            # log shutdown process
            logger --priority daemon.alert --tag shutdown_if_battery_low "Battery low: $BATTERY_CAPACITY %. Shutting down initiated."

            shutdown --poweroff "$SHUTDOWN_DELAY"
        elif [ "$BATTERY_CAPACITY" -lt "$BATTERY_WARN" ]; then
            logger --priority daemon.warning --tag shutdown_if_battery_low "Battery low: $BATTERY_CAPACITY %. Shutting down at ${BATTERY_SHUTDOWN} %."
        fi
    fi

    sleep 1m
done
