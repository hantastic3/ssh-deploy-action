#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${ALIYUN_USERNAME:-}" || -z "${ALIYUN_PASSWORD:-}" ]]; then
  echo "ALIYUN_USERNAME and ALIYUN_PASSWORD are required for Aliyun deployment."
  exit 1
fi

if [[ -z "${REGISTRY:-}" || -z "${REPOSITORY:-}" ]]; then
  echo "REGISTRY and REPOSITORY are required."
  exit 1
fi

sudo docker image prune -a -f

sudo docker login "$REGISTRY" \
  -u "$ALIYUN_USERNAME" \
  --password "$ALIYUN_PASSWORD"

cd "$WORKING_DIRECTORY"

if [[ "$IMAGE_TAG" != "latest" ]]; then
  sed -i "s|$REPOSITORY:[0-9]*\.[0-9]*\.[0-9]*|$REPOSITORY:$IMAGE_TAG|g" docker-compose.yml
fi

sudo docker compose pull
sudo docker compose up $COMPOSE_UP_ARGS

sudo docker system prune -af
