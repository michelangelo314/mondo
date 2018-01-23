#!/usr/bin/env bash

set -x 

docker container prune -f

cd ..
rm -rf logs
docker build --build-arg pool_address=$POOL_ADDRESS \
             --build-arg pool_password=$POOL_PASSWORD \
             --build-arg wallet_address=$WALLET_ADDRESS \
             -t turtlepower/mondo .