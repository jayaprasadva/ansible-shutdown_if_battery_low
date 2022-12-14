#!/bin/bash
#
# Check every minute for shutdown in case of power failure and low battery level
#

LIMIT_WARN="$1"
LIMIT_SHUTDOWN="$2"
SHUTDOWN_COMMAND="${3:-}"
SLEEP="$4"
BATTERY="${5:-0}"

# infinite loop
while true; do

    # Example output from acpi --battery
    # Battery 0: Full, 100%
    # Battery 0: Discharging, 88%, 03:13:24 remaining
    # Battery 0: Charging, 87%, 00:25:53 until charged

    # Get the battery status line indicating the discharging condition.
    BATTERY_CAPACITY="$(acpi --battery | grep "^Battery $BATTERY:" | grep Discharging | sed 's/.*, \([0-9]\+\)%.*/\1/g')"

    # If battery is in discharging state.
    if [ -n "$BATTERY_CAPACITY" ]; then
        if (( "$BATTERY_CAPACITY" <= "$LIMIT_SHUTDOWN" )); then
            # log shutdown process
            logger --priority daemon.alert --tag shutdown_if_battery_low "Battery low: $BATTERY_CAPACITY %. Shutdown initiated."

            # Bash fallback `||` does not work when passed as variable.
            if [[ -n "$SHUTDOWN_COMMAND" ]]; then
                $SHUTDOWN_COMMAND
            else
                # Testing for molly-guard is only needed in non-default
                # molly-guard configuration because this script was not started
                # over ssh.
                /lib/molly-guard/shutdown --poweroff +5 || shutdown --poweroff +5
            fi
        elif (( "$BATTERY_CAPACITY" <= "$LIMIT_WARN" )); then
            logger --priority daemon.warning --tag shutdown_if_battery_low "Battery low: $BATTERY_CAPACITY %. Shutting down at ${LIMIT_SHUTDOWN} %."
        fi
    fi

    sleep "$SLEEP"
done
