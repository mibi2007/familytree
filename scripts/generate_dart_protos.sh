#!/bin/bash
# Generate Dart gRPC specific code
# Run this from the project root

# Ensure the output directory exists
mkdir -p familytree_flutter/packages/shared_package/lib/infrastructure/grpc/generated

# Protoc generation for Dart
# We use grpc: option to generate gRPC client code
protoc --dart_out=grpc:familytree_flutter/packages/shared_package/lib/infrastructure/grpc/generated \
    -I . \
    proto/common/v1/common.proto \
    proto/auth/v1/auth.proto \
    proto/family/v1/family.proto \
    google/protobuf/timestamp.proto \
    google/protobuf/empty.proto

echo "Dart gRPC code generated in familytree_flutter/packages/shared_package/lib/infrastructure/grpc/generated"
