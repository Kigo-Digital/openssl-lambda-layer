#!/bin/sh

# Clean up previous layer.zip if it exists
rm -f layer/layer.zip

# Build the Docker image
docker build --platform linux/amd64 -t openssl-layer .

# Run the container in the background and make sure it stays running
CONTAINER_ID=$(docker run -d openssl-layer tail -f /dev/null)

# Give the container some time to fully initialize
sleep 10

# Check if layer.zip exists
if ! docker exec $CONTAINER_ID ls /tmp/layer/layer.zip; then
    echo "layer.zip does not exist on the container."
    docker logs $CONTAINER_ID
    docker stop $CONTAINER_ID
    exit 1
fi

# Copy out the layer.zip
if ! docker cp "${CONTAINER_ID}:/tmp/layer/layer.zip" ./layer/; then
    echo "Failed to copy layer.zip from container"
    docker logs $CONTAINER_ID
    docker stop $CONTAINER_ID
    exit 1
fi

# Optionally, print the contents of the lib directory
docker exec $CONTAINER_ID ls -l /tmp/layer/lib

# Stop the container
docker stop $CONTAINER_ID
