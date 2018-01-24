#!/usr/bin/env bash

## Starts the turtlepower miner (xmr stak) container


## this needs to be turned into an application where $1 selects start or stop

set -o errexit
set -o pipefail

CONTAINER_NAME=turtlepower-mondo
IMAGE_NAME=turtlepower/miner
CONFIG_PATH=/usr/local/etc/turtlepower/xmr-config.txt

_start() {
    # This will only start up if the container isnt already running
    if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Starting up docker"
        docker create --rm --name "$CONTAINER_NAME" \
                   -p 8080:8080 \
                   "$IMAGE_NAME" /sbin/my_init
        docker cp "$CONFIG_PATH" "$CONTAINER_NAME":/usr/local/etc/
        docker start "$CONTAINER_NAME"
        echo "Cowabunga!! You're miner is running. Use stop.sh to stop the miner. Connect to the miner web interface using localhost:8080!! TURTLE POWER!!"
    else
        echo "Whoa dude! It looks like $CONTAINER_NAME already has been started!"
    fi
}