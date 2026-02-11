#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${AWS_REGION:-}" ]]; then
  echo "AWS_REGION is required for AWS/ECR deployment."
  exit 1
fi

if [[ -z "${REGISTRY:-}" || -z "${REPOSITORY:-}" ]]; then
  echo "REGISTRY and REPOSITORY are required."
  exit 1
fi

sudo docker image prune -a -f

sudo aws ecr get-login-password --region "$AWS_REGION" | \
  sudo docker login --username AWS --password-stdin "$REGISTRY"

cd "$WORKING_DIRECTORY"

if [[ "$IMAGE_TAG" != "latest" ]]; then
  sed -i "s|$REPOSITORY:[0-9]*\.[0-9]*\.[0-9]*|$REPOSITORY:$IMAGE_TAG|g" docker-compose.yml
fi

sudo docker compose pull
sudo docker compose up $COMPOSE_UP_ARGS

sudo docker system prune -af
