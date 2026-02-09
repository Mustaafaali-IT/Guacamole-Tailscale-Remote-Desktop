#!/usr/bin/env bash

# Exit immediately if a command fails
set -e

# Move to the docker directory (relative to this script)
cd "$(dirname "$0")/../docker"

# Start containers in detached mode
docker compose up -d
