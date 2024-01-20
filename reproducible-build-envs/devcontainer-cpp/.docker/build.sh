#!/usr/bin/env bash

# build docker images
set -x
docker build -t devcontainer-base -f Dockerfile.base .
docker build -t devcontainer-cpp -f Dockerfile.devenv .
