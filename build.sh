#!/bin/bash

# Detect platform
PLATFORM="linux/amd64"
if [ "$(uname -m)" = "arm64" ] || [ "$(uname -m)" = "aarch64" ]; then
    PLATFORM="linux/arm64"
fi

# Build the Docker image and load it into local Docker daemon
docker buildx build \
    --platform $PLATFORM \
    -t monads:latest \
    --load \
    .
