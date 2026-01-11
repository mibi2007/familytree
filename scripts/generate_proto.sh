#!/bin/bash
# Navigate to the project root (one level up from this script)
cd "$(dirname "$0")/.."

# Run generation scripts
sh scripts/generate_go_protos.sh
sh scripts/generate_dart_protos.sh
