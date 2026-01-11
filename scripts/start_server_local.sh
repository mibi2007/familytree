#!/bin/bash

# Configuration for Local Development with Firebase Emulators
export FIREBASE_AUTH_EMULATOR_HOST="localhost:9099"
export GOOGLE_CLOUD_PROJECT="mibi-family-tree-dev"
export GCLOUD_PROJECT="mibi-family-tree-dev"

echo "Starting Go Server with Firebase Emulator config..."
echo "Project ID: $GOOGLE_CLOUD_PROJECT"
echo "Auth Emulator: $FIREBASE_AUTH_EMULATOR_HOST"

cd familytree_go || exit
go run cmd/server/main.go
