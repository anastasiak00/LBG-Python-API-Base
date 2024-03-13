#!/bin/bash
set

DOCKER_IMAGE="lbg"
export VERSION=1.1 

cleanup() {

    echo "Cleaning up previous build artifacts..."

    sleep 3

    docker rm -f $(docker ps -aq) || true

    docker rmi -f $(docker images) || true

    echo "Cleanup done."

}

build_docker() {

    echo "Building the Docker image..."

    sleep 3

    docker build -t $DOCKER_IMAGE .

}

modify_app() {

    echo "Modifying the application..."

    sleep 3

   export PORT=5001

    echo "Modifications done. Port is now set to $PORT"

}

run_docker() {

    echo "Running Docker container..."

    sleep 3

    docker run -d -p 80:$PORT -e PORT=$PORT $DOCKER_IMAGE

}

echo "Starting build process..."

sleep 3

cleanup

build_docker

modify_app

run_docker

echo "Build process completed successfully."