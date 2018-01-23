#!/usr/bin/env bash

## Starts the turtlecoind container

set -o errexit
set -o pipefail

CONTAINER_NAME=turtlepower-mondo

which docker &> /dev/null
if [ $? -eq 0 ]; then
    docker --version | grep "Docker version" &> /dev/null
    if [ $? -eq 0 ]; then
        echo "Docker found at [`which docker`]"
    else
        echo "FATAL: Unable to find docker installation. "
        exit 1
    fi
else
    echo "FATAL: Unable to find docker installation."
    exit 1
fi

# This will only start up if the container isnt already running
if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Starting up docker"
    cd ..
    mkdir -p logs
    docker run --rm --name "$CONTAINER_NAME" \
               -p 8080:8080 \
               -d turtlepower/mondo /sbin/my_init
else
    echo "Whoa dude! It looks like $CONTAINER_NAME already has been started!"
fi
