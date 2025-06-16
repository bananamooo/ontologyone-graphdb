#!/bin/bash

# Start GraphDB in the background
/opt/graphdb/dist/bin/graphdb &

# Wait for GraphDB to become available
echo "Waiting for GraphDB to start..."
until curl -s -o /dev/null http://localhost:7200/repositories; do
  sleep 1
done

# Check if the repository already exists
REPO_EXISTS=$(curl -s http://localhost:7200/repositories | grep ontologyone)

if [ -z "$REPO_EXISTS" ]; then
  echo "Creating default repository 'ontologyone'..."
  curl -X POST \
    -H "Content-Type: application/json" \
    --data @/repo-config.json \
    http://localhost:7200/rest/repositories
else
  echo "Repository 'ontologyone' already exists."
fi

# Keep container running
wait
