#!/usr/bin/env bash

## Installs the turtle power miner!

echo "Installing the turtlepower miner!"

_detect_os() {
    if [ "$(uname -s)" = "Darwin" ]; then
        DISTRO=osx
    elif [ ! -z "$(uname -v | grep Ubuntu)" ]; then
        DISTRO=ubuntu
    else
        echo "Mega bummer! Mondo requires OSX or Ubuntu and you don't appear to have either. Please check out the project on github and add support for your distro! (https://github.com/michelangelo314/mondo)"
        exit 1
    fi
    echo "$DISTRO detected"
}

_install_docker_osx() {
    echo "Woah, dude! OSX is groovy but docker on mac is funky to install from the terminal. Go here and install docker for mac first: https://www.docker.com/docker-mac"
    echo "Once you've installed docker rereun this install script! Cowabunga!"
    exit 1
}

_install_docker_ubuntu() {
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    sudo usermod -aG docker "${USER}"
}

_install_docker() {
    case "$DISTRO" in
        osx) _install_docker_osx ;;
        ubuntu) _install_docker_ubuntu ;;
        *) echo "Bummer! I dont know how to install for your platform. Exiting!"; exit 1;;
    esac
}

_check_docker() {
    # Check to ensure docker is installed
    which docker &> /dev/null
    if [ $? -eq 0 ]; then
        docker --version | grep "Docker version" &> /dev/null
        if [ $? -eq 0 ]; then
            echo "Docker found at [`which docker`]"
        else
            echo "Unable to find docker installation. Attempting to install..."
            _install_docker
        fi
    else
        echo "Unable to find docker installation. Attempting to install..."
        _install_docker
    fi
}

# detect os and check docker is installed
_detect_os
_check_docker

## Prepull the docker image
docker pull turtlepower/mondo

CONFIG_PATH=/usr/local/etc/mondo-config.txt
APP_PATH=/usr/local/bin/mondo

echo "Installing mondo script. I require sudo for this to install to $APP_PATH"

sudo curl --output "$CONFIG_PATH" -sL "https://raw.githubusercontent.com/michelangelo314/mondo/master/config.txt"
echo "Miner configuration file installed to ${CONFIG_PATH}"
echo "Open your config file with a text editor and change it to use your pool and wallet information."
sudo curl --output "$APP_PATH" -sL "https://raw.githubusercontent.com/michelangelo314/mondo/master/mondo.sh"
sudo chmod +x "$APP_PATH"
echo "Miner app file installed to ${APP_PATH}"

echo "Turtle power miner installed! Make sure ${APP_PATH} is on your path and call mondo. Cowabunga!!"