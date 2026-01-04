#!/bin/bash

# Exit on error
set -e

# Help function
show_help() {
    echo "Usage: ./deploy.sh [app] [env]"
    echo ""
    echo "Arguments:"
    echo "  app  : user | admin | all"
    echo "  env  : dev | stg | prod"
    echo ""
    echo "Example:"
    echo "  ./deploy.sh user dev"
    echo "  ./deploy.sh all prod"
}

# Check arguments
if [ "$#" -ne 2 ]; then
    show_help
    exit 1
fi

APP=$1
ENV=$2

# Validate ENV
if [[ "$ENV" != "dev" && "$ENV" != "stg" && "$ENV" != "prod" ]]; then
    echo "Error: Invalid environment '$ENV'. Use 'dev', 'stg', or 'prod'."
    exit 1
fi

# Paths
ROOT_DIR=$(pwd)
FLUTTER_APPS_DIR="$ROOT_DIR/familytree_flutter/apps"
FIREBASE_DIR="$ROOT_DIR/familytree_firebase"

# Start overall timer
START_TIME=$(date)

# Function to build and deploy a single app
deploy_app() {
    local app_name=$1 # user | admin
    local app_dir="$FLUTTER_APPS_DIR/${app_name}_app"
    local target_name="${app_name}_${ENV}"
    local dest_dir="$FIREBASE_DIR/hosting/$ENV/$app_name"
    local app_start=$(date)

    echo "----------------------------------------------------"
    echo "🚀 Deploying $app_name to $ENV..."
    echo "Started at: $app_start"
    echo "----------------------------------------------------"

    # 1. Build Flutter Web
    local target_file="lib/main_${ENV}.dart"
    echo "📦 Building $app_name for Web using target $target_file..."
    cd "$app_dir"
    flutter build web --release --target "$target_file"

    # 2. Sync to Firebase Hosting folder
    echo "📂 Staging artifacts to $dest_dir..."
    mkdir -p "$dest_dir"
    rm -rf "$dest_dir/*"
    cp -r build/web/* "$dest_dir/"

    # 3. Deploy to Firebase
    echo "🔥 Executing Firebase Deploy for target: $target_name..."
    cd "$FIREBASE_DIR"
    firebase deploy --only hosting:$target_name -P $ENV

    echo "✅ $app_name ($ENV) deployed successfully!"
    echo "App completion at: $(date)"
    cd "$ROOT_DIR"
}

# Execution logic
echo "🎬 Deployment process started at: $START_TIME"

if [[ "$APP" == "user" ]]; then
    deploy_app "user"
elif [[ "$APP" == "admin" ]]; then
    deploy_app "admin"
elif [[ "$APP" == "all" ]]; then
    deploy_app "user"
    deploy_app "admin"
else
    echo "Error: Invalid app '$APP'. Use 'user', 'admin', or 'all'."
    exit 1
fi

echo "----------------------------------------------------"
echo "🏁 Overall Deployment Finished"
echo "Started    : $START_TIME"
echo "Completed  : $(date)"
echo "----------------------------------------------------"
echo "Done!"
