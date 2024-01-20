#!/usr/bin/env bash

# starts shell in a temporary container,
# so that you can test your customization and other things
source .docker/.env
docker compose -f .docker/docker-compose.yaml run --rm builder bash
