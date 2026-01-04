# Start Firebase Emulators with seed data and auto-export
# This script works best with Bash/Git Bash on Windows.
# Emulator UI: http://localhost:4000

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR/../familytree_firebase" || exit

echo "Starting Firebase Emulators from: $(pwd)"
firebase emulators:start --only auth,database,storage --import=./seeds --export-on-exit=./seeds
