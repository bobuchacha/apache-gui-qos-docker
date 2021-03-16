#! /bin/bash
set -e

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

elif [ $command = "run" ]; then
    docker run -d \
    -it \
    --name $CONTAINER_NAME \
    -p 80:80/tcp \
    -p 443:443/tcp \
    -p 9999:9999/tcp \
    --memory=8g \
    --memory-reservation=2g \
    --cpus=4 \
    --mount type=bind,source="$(pwd)"/inetpub/wwwroot,target=/inetpub/wwwroot \
    --mount type=bind,source="$(pwd)"/apache,target=/etc/apache2 \
    $IMAGE_TAG

elif [ $command = "rm" ]; then
    stop
    docker container rm $CONTAINER_NAME

elif [ $command = "push" ]; then

    COMMIT_MSG=$2
    
    if [ ! $COMMIT_MSG ]; 
    then 
        COMMIT_MSG="Commit" 
    fi

    git add .
    git commit -m $COMMIT_MSG
    git push

elif [ $command = "pull" ]; then
    git pull
fi