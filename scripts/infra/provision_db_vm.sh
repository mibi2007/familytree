#!/bin/bash
set -e

# Configuration
PROJECT_ID=${1:-"familytree-db-all"}
ZONE=${2:-"asia-southeast1-a"}

# Interactive Password Prompt
if [ -z "$3" ]; then
    read -s -p "Enter Database Password for PROD (prod_user): " PASS_PROD
    echo ""
else
    PASS_PROD=$3
fi

if [ -z "$4" ]; then
    read -s -p "Enter Database Password for DEV (dev_user): " PASS_DEV
    echo ""
else
    PASS_DEV=$4
fi

if [[ -z "$PASS_PROD" || -z "$PASS_DEV" ]]; then
    echo "Error: Passwords cannot be empty."
    exit 1
fi

INSTANCE_NAME="familytree-db-main"
MACHINE_TYPE="e2-small" # Optimized: 2 vCPU, 2GB RAM
IMAGE_FAMILY="ubuntu-2404-lts-amd64" # Ubuntu 24.04 LTS
IMAGE_PROJECT="ubuntu-os-cloud"
DISK_SIZE="20GB"
DISK_TYPE="pd-balanced" # Optimized: Balanced Performance/Cost

echo "----------------------------------------------------"
echo "🛠️  Provisioning Shared Database VM (Prod + Dev)..."
echo "Project: $PROJECT_ID"
echo "Zone: $ZONE"
echo "Instance: $INSTANCE_NAME"
echo "Machine: $MACHINE_TYPE"
echo "Disk: $DISK_SIZE ($DISK_TYPE)"
echo "----------------------------------------------------"

if [[ "$PROJECT_ID" == "YOUR_PROJECT_ID" ]]; then
    echo "Error: Please provide a Project ID."
    echo "Usage: ./provision_db_vm.sh <PROJECT_ID> <ZONE> <PROD_PASS> <DEV_PASS>"
    exit 1
fi

# Create Instance
gcloud compute instances create "$INSTANCE_NAME" \
    --project="$PROJECT_ID" \
    --zone="$ZONE" \
    --machine-type="$MACHINE_TYPE" \
    --image-family="$IMAGE_FAMILY" \
    --image-project="$IMAGE_PROJECT" \
    --tags="db-server,http-server,https-server" \
    --metadata-from-file startup-script=./scripts/infra/vm_startup.sh \
    --metadata db_password_prod="$PASS_PROD",db_password_dev="$PASS_DEV" \
    --boot-disk-size="$DISK_SIZE" \
    --boot-disk-type="$DISK_TYPE" \
    --network-tier="STANDARD" \


echo "----------------------------------------------------"
echo "✅ VM Created Successfully!"
echo "----------------------------------------------------"
echo "Outputting external IP..."
gcloud compute instances describe "$INSTANCE_NAME" \
    --project="$PROJECT_ID" \
    --zone="$ZONE" \
    --format='get(networkInterfaces[0].accessConfigs[0].natIP)'

echo ""
echo "⏳ Please wait a few minutes for the startup script to complete."
echo "----------------------------------------------------"
echo "Databases:"
echo "1. Prod: family_tree_prod (User: prod_user)"
echo "2. Dev:  family_tree_dev  (User: dev_user)"
echo "----------------------------------------------------"
