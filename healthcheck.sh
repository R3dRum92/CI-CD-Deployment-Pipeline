#!/bin/bash

HEALTH_URL="http://localhost:5000/health"
MAX_RETRIES=10
SLEEP_TIME=5
RETRY_COUNT=0

echo "Starting health check for $HEALTH_URL..."

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $HEALTH_URL)

    if [ "$HTTP_STATUS" -eq 200 ]; then
        echo "Application is UP and HEALTHY (HTTP Status: $HTTP_STATUS)"
        exit 0
    else
        RETRY_COUNT=$((RETRY_COUNT + 1))
        echo "Health check failed (HTTP Status: $HTTP_STATUS). Retrying in $SLEEP_TIME seconds... (Attempt $RETRY_COUNT/$MAX_RETRIES)"
        sleep $SLEEP_TIME
    fi
done

echo "Health check failed after $MAX_RETRIES attempts."
exit 1
