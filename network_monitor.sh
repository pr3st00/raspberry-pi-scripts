#!/bin/bash

DEBUG=0

SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")
source ${DIR}/subs/functions.sh

WAIT_BOOT=25
WAIT_MONITOR=60
INTERFACE=wlan0
LOGFILE=/var/log/network_monitor.log

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

attempts=0

while true ; do
	if ifconfig $INTERFACE | grep -q "inet addr:" ; then
		debug "[UP]"
		attempts=0
		sleep $WAIT_MONITOR
	else
		let "attempts++"
		debug "[DOWN] (attempts $attempts)"
		echo "$(date) Network is down... tried $attempts times so far" > $LOGFILE
		ifdown --force $INTERFACE
		ifup $INTERFACE
		sleep 60
	fi
done

# EOF
