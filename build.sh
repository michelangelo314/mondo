#!/usr/bin/env bash

set -x 

docker container prune -f

docker build -t turtlepower/mondo .