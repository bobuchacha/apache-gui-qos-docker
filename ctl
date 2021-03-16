#! /bin/bash
command=$1
IMAGE_TAG="thang:apache-server"
CONTAINER_NAME="apache-good"

stop() {
    docker container stop $CONTAINER_NAME
}

if [ $command = "start" ]; then
    docker container start $CONTAINER_NAME

elif [ $command = "stop" ]; then
    stop

elif [ $command = "build" ]; then
    docker build \
    -t $IMAGE_TAG \
    .

elif [ $command = "restart" ]; then
    docker container restart $CONTAINER_NAME

elif [ $command = "sh" ]; then
    docker container exec -it $CONTAINER_NAME bash

elif [ $command = "sh" ]; then
    docker run -d \
    -it \
    --name $CONTAINER_NAME \
    -p 80:80/tcp \
    -p 443:443/tcp \
    -p 9999:9999/tcp \
    --memory=8g \
    --memory-swap=2g \
    --memory-reservation=2g \
    --kernel-memory=512m \
    --cpus=8 \
    --mount type=bind,source="$(pwd)"/inetpub/wwwroot,target=/inetpub/wwwroot \
    --mount type=bind,source="$(pwd)"/apache,target=/etc/apache2 \
    $IMAGE_TAG

elif [ $command = "rm" ]; then
    stop
    docker container rm $CONTAINER_NAME

fi