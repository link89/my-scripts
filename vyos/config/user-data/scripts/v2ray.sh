#!/bin/sh

# start-stop script for v2ray(for vyos)
# ref: https://gist.github.com/alobato/1968852

set -e

NAME=v2ray
PIDFILE=/var/run/v2ray.pid
DAEMON=/config/user-data/v2ray/v2ray

DAEMON_OPTS="-config /config/user-data/v2ray/config.json"

export PATH="${PATH:+$PATH:}/usr/sbin:/sbin"

case "$1" in
  start)
    echo -n "Starting daemon: "$NAME
    start-stop-daemon --start --quiet --pidfile $PIDFILE --make-pidfile --background --exec $DAEMON -- $DAEMON_OPTS
    echo "."
    ;;
  stop)
    echo -n "Stopping daemon: "$NAME
    start-stop-daemon --stop --quiet --oknodo --retry 5 --pidfile $PIDFILE --remove-pidfile
    echo "."
    ;;
  restart)
    echo "Restarting daemon: "$NAME
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