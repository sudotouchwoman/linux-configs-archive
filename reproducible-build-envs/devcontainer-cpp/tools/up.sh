#!/usr/bin/env bash

# wrapper for devcontainer setup - with proper UID/GID forwarding
# launches container in the background, so that it can be accessed
# by vscode
source .docker/.env
docker compose -f .docker/docker-compose.yaml up -d
