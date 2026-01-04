#!/bin/bash
# Generate Go gRPC code
# Run this from the project root

# Generate for all services
# We output to the familytree_go directory, using source_relative paths
# so that the output matches the directory structure expected by the Go module.

protoc --go_out=familytree_go --go_opt=paths=source_relative \
    --go-grpc_out=familytree_go --go-grpc_opt=paths=source_relative \
    -I . \
    proto/common/v1/common.proto \
    proto/auth/v1/auth.proto \
    proto/family/v1/family.proto

echo "Go gRPC code generated in familytree_go/proto/"
