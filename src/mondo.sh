#!/usr/bin/env bash

## Starts the turtlepower miner (xmr stak) container

set -o errexit
set -o pipefail

CONTAINER_NAME=turtlepower-mondo
IMAGE_NAME=turtlepower/mondo
CONFIG_PATH=/usr/local/etc/mondo-config.txt

_print_usage() {
    echo "Usage: $0 <start|stop|help>"
}

_start() {
    # This will only start up if the container isnt already running
    if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Starting up docker"
        docker create --rm --name "$CONTAINER_NAME" \
                   -p 8080:8080 \
                   "$IMAGE_NAME" /sbin/my_init
        docker cp "$CONFIG_PATH" "$CONTAINER_NAME":/usr/local/etc/config.txt
        docker start "$CONTAINER_NAME"
        echo "Cowabunga!! You're miner is running. Use mondo stop to stop the miner. Connect to the miner web interface using localhost:8080!! TURTLE POWER!!"
    else
        echo "Whoa dude! It looks like $CONTAINER_NAME already has been started!"
    fi
}

_stop() {
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Stopping $CONTAINER_NAME"
        docker rm --force $CONTAINER_NAME >/dev/null 2>&1
        echo "$CONTAINER_NAME stopped. Gnarly!"
    else
        echo "Bummer! It doesn't look like $CONTAINER_NAME is running. Try docker ps and docker kill manually."
    fi
}

case "$1" in 
    start) _start ;;
    stop) _stop ;;
    *) _print_usage
esac