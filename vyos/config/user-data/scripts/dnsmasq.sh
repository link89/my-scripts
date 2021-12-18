#!/bin/sh

# start-stop script for dnsmasq (for vyos)
# ref: https://gist.github.com/alobato/1968852

set -e

NAME=dnsmasq
PIDFILE=/var/run/dnsmasq.pid
DAEMON=/config/user-data/dnsmasq/bin/dnsmasq

DAEMON_OPTS="--conf-file=/config/user-data/dnsmasq/dnsmasq.conf --pid-file=$PIDFILE"

export PATH="${PATH:+$PATH:}/usr/sbin:/sbin"

case "$1" in
  start)
    echo -n "Starting daemon: "$NAME
    start-stop-daemon --start --quiet --pidfile $PIDFILE --exec $DAEMON -- $DAEMON_OPTS
    echo "."
    ;;
  stop)
    echo -n "Stopping daemon: "$NAME
    start-stop-daemon --stop --quiet --oknodo --retry 5 --pidfile $PIDFILE
    echo "."
    ;;
  restart)
    echo -n "Restarting daemon: "$NAME
    $0 stop
    sleep 5
    $0 start
    echo "."
    ;;
  *)
    echo "Usage: "$1" {start|stop|restart}"
    exit 1
esac

exit 0