#!/bin/bash
set -e

# Usage: ./scripts/setup_gce.sh [env]
# Example: ./scripts/setup_gce.sh prod
# Default env is "dev"

ENV=${1:-dev}
ENV_FILE="familytree_go/.env.$ENV"

echo "Using environment configuration: $ENV_FILE"

if [[ ! -f "$ENV_FILE" ]]; then
    echo "Error: Configuration file $ENV_FILE not found."
    echo "Please create it with the necessary variables (PROJECT_ID, REGION, ZONE, INSTANCE_NAME, etc.) and runtime config."
    exit 1
fi

# Load variables from env file
set -a
source "$ENV_FILE"
set +a

# Defaults
# Defaults
PROJECT_ID=${PROJECT_ID:-"mibi-family-tree-$ENV"}
REGION=${REGION:-"asia-southeast1"}
ZONE=${ZONE:-"asia-southeast1-b"}
INSTANCE_NAME=${INSTANCE_NAME:-"familytree-$ENV-server"}
MACHINE_TYPE=${MACHINE_TYPE:-"e2-micro"}
IMAGE_FAMILY=${IMAGE_FAMILY:-"ubuntu-2204-lts"}
IMAGE_PROJECT=${IMAGE_PROJECT:-"ubuntu-os-cloud"}
STATIC_IP_NAME=${STATIC_IP_NAME:-"familytree-$ENV-ip"}

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "Error: gcloud CLI is not installed."
    exit 1
fi

echo "🚀 Setting up GCP infrastructure for $INSTANCE_NAME..."

# 1. Enable Compute Engine API
echo "🔌 Enabling Compute Engine API..."
gcloud services enable compute.googleapis.com --project=$PROJECT_ID

# 2. Reserve Static IP Address
echo "🌐 Reserving static IP address ($STATIC_IP_NAME)..."
if gcloud compute addresses describe $STATIC_IP_NAME --region=$REGION --project=$PROJECT_ID &> /dev/null; then
    echo "  - IP address already exists."
else
    gcloud compute addresses create $STATIC_IP_NAME --region=$REGION --project=$PROJECT_ID
    echo "  - Static IP created."
fi

STATIC_IP=$(gcloud compute addresses describe $STATIC_IP_NAME --region=$REGION --project=$PROJECT_ID --format='get(address)')
echo "  - Reserved IP: $STATIC_IP"

# 3. Create Firewall Rules
echo "🔥 Configuring firewall rules..."
if gcloud compute firewall-rules describe allow-http-https --project=$PROJECT_ID &> /dev/null; then
    echo "  - Firewall rule 'allow-http-https' already exists."
else
    gcloud compute firewall-rules create allow-http-https \
        --allow tcp:80,tcp:443 \
        --target-tags=http-server,https-server \
        --description="Allow HTTP/HTTPS traffic" \
        --project=$PROJECT_ID
fi

# 4. Create VM Instance
echo "💻 Creating VM instance ($INSTANCE_NAME)..."
if gcloud compute instances describe $INSTANCE_NAME --zone=$ZONE --project=$PROJECT_ID &> /dev/null; then
    echo "  - VM instance already exists."
else
    gcloud compute instances create $INSTANCE_NAME \
        --project=$PROJECT_ID \
        --zone=$ZONE \
        --machine-type=$MACHINE_TYPE \
        --image-family=$IMAGE_FAMILY \
        --image-project=$IMAGE_PROJECT \
        --boot-disk-size=20GB \
        --address=$STATIC_IP \
        --tags=http-server,https-server \
        --metadata=startup-script='#! /bin/bash
        apt-get update
        apt-get install -y docker.io docker-compose
        usermod -aG docker ubuntu

        systemctl enable docker
        systemctl start docker
        '
    echo "  - VM instance created."
fi


echo ""
echo "🔥 IMPORTANT: Configure DNS"
echo "Please update your DNS settings for 'family-be.binhhm.dev' to point to the IP below."
echo "Update your $ENV_FILE file if it's not already set:"
echo "--------------------------------------------------------"
echo "DOMAIN_NAME=family-be.binhhm.dev"
echo "--------------------------------------------------------"
echo ""
echo "✅ Infrastructure setup complete!"
echo "Server IP: $STATIC_IP"
echo "To SSH into the server: gcloud compute ssh $INSTANCE_NAME --zone=$ZONE --project=$PROJECT_ID"
