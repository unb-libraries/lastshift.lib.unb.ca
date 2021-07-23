#!/usr/bin/env sh
MINIMUM_INDEX_FILESIZE=200
INDEX_FILESIZE=1
if [ "$DEPLOY_ENV" = "local" ]; then
  while [ ! -f /app/html/index.html ] || [ "$INDEX_FILESIZE" -lt "$MINIMUM_INDEX_FILESIZE" ]
  do
    echo "Waiting for local builder to deploy..."
    sleep 2
    INDEX_FILESIZE=$(wc -c <"/app/html/index.html")
  done
fi
