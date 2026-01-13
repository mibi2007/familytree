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
    proto/family/v1/family.proto \
    proto/chat/v1/chat.proto \
    proto/system/v1/system.proto

# Generate Swagger/OpenAPI v2
# We output to the Admin App's web directory so it can be served statically.
echo "Generating Swagger definitions..."
protoc --openapiv2_out=json_names_for_fields=false:familytree_flutter/apps/admin_app/web/swagger \
    --openapiv2_opt=allow_merge=true,merge_file_name=api \
    -I . \
    proto/common/v1/common.proto \
    proto/auth/v1/auth.proto \
    proto/family/v1/family.proto \
   proto/chat/v1/chat.proto \
    proto/system/v1/system.proto

echo "Go gRPC code generated in familytree_go/proto/"
