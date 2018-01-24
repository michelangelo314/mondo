CONTAINER_NAME=turtlepower-mondo

if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping $CONTAINER_NAME"
    docker rm --force $CONTAINER_NAME >/dev/null 2>&1
    echo "$CONTAINER_NAME stopped. Gnarly!"
else
    echo "Bummer! It doesn't look like $CONTAINER_NAME is running. Try docker ps and docker kill manually."
fi
