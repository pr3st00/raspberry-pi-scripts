#!/bin/bash

DEBUG=0

SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")
source ${DIR}/subs/functions.sh

WAIT_BOOT=5
WAIT_MONITOR=60

function debug() {
	if [[ $DEBUG -eq 1 ]]; then
		info "$@";
	fi
}

info "Starting network monitor"

# Wait for boot process to complete
info "Sleeping for $WAIT_BOOT (s) for boot to finish..." 
sleep $WAIT_BOOT

# Then monitor for lost connection
info "Starting monitor process. (WAIT_MONITOR = $WAIT_MONITOR)"

while true ; do
	if ifconfig wlan0 | grep -q "inet addr:" ; then
		debug "[UP]"
		sleep $WAIT_MONITOR
	else
		debug "[DOWN]"
		ifup --force wlan0
		sleep 60
	fi
done

# EOF
