#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/../docker"

echo "Docker Compose status:"
docker compose ps

echo ""
echo "Running containers:"
docker ps
