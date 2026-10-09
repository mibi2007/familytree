#!/bin/bash
set -e

# Usage: ./scripts/deploy_backend.sh [env]
# Example: ./scripts/deploy_backend.sh prod
# Default env is "dev"

ENV=${1:-dev}
ENV_FILE="familytree_go/.env.$ENV"

echo "Using environment configuration: $ENV_FILE"

if [[ ! -f "$ENV_FILE" ]]; then
    echo "Error: Configuration file $ENV_FILE not found."
    echo "Please create it with the necessary variables (PROJECT_ID, ZONE, INSTANCE_NAME, REMOTE_USER, REMOTE_DIR) and runtime config."
    exit 1
fi

# Load variables from env file
set -a
source "$ENV_FILE"
set +a

# Default values if not set in .env
REMOTE_USER=${REMOTE_USER:-ubuntu}
REMOTE_DIR=${REMOTE_DIR:-"/home/$REMOTE_USER/familytree-backend"}
ZONE=${ZONE:-"asia-southeast1-b"}

echo "🚀 Deploying backend to $INSTANCE_NAME ($PROJECT_ID) in zone $ZONE..."

echo "🏗️  Building backend locally (cross-compile for Linux/AMD64)..."
    cd familytree_go
    GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o server ./cmd/server/main.go
    if [ $? -ne 0 ]; then
        echo "Error: Local build failed."
        exit 1
    fi
    cd ..

    # 1. Package Application (Binary + Dockerfile.deploy + Configs)
    echo "📦 Packaging deployment artifacts..."
    # We only need the binary, the deploy Dockerfile, and docker-compose.yml/migrations
    tar -czf backend-deploy.tar.gz \
        -C familytree_go server Dockerfile.deploy docker-compose.yml Caddyfile migrations .env.dev .env.prod
    
    # Cleanup binary after packaging
    rm familytree_go/server

# 2. Upload to Server
echo "📤 Uploading to server..."
# Copy to home directory first to avoid permission issues
gcloud compute scp backend-deploy.tar.gz $REMOTE_USER@$INSTANCE_NAME:backend-deploy.tar.gz --zone=$ZONE --project=$PROJECT_ID

# 3. Deploy on Server
echo "🔄 Restarting services..."
# We copy the specific env file (e.g. .env.dev) to .env on the server
gcloud compute ssh $REMOTE_USER@$INSTANCE_NAME --zone=$ZONE --project=$PROJECT_ID --command="mkdir -p $REMOTE_DIR && mv ~/backend-deploy.tar.gz $REMOTE_DIR/ && cd $REMOTE_DIR && tar -xzf backend-deploy.tar.gz && ls -l server && cp .env.$ENV .env && mv Dockerfile.deploy Dockerfile && sudo docker compose up -d --build --remove-orphans && sudo docker compose restart caddy && rm backend-deploy.tar.gz"

# Cleanup local archive
rm backend-deploy.tar.gz

echo "✅ Deployment complete!"
