#!/usr/bin/env bash

## Installs the turtle power miner!

echo "Installing the turtlepower miner!"

# Check to ensure docker is installed
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

## coming soon, auto install docker (on linux)

## Prepull the docker image
# docker pull 

CONFIG_PATH=/usr/local/etc/turtlepower/xmr-config.txt
APP_PATH=/usr/local/bin/mondo

echo "Installing mondo script. I require sudo for this to install to $APP_PATH"

sudo curl --output "$CONFIG_PATH" -sL "https://raw.githubusercontent.com/michelangelo314/mondo/master/config.txt"
echo "Miner configuration file installed to ${CONFIG_PATH}"
sudo curl --output "$APP_PATH" -sL "https://raw.githubusercontent.com/michelangelo314/mondo/master/mondo.sh"
sudo chmod +x "$APP_PATH"
echo "Miner app file installed to ${APP_PATH}"

echo "Turtle power miner installed! Make sure ${APP_PATH} is on your path and call mondo. Cowabunga!!"