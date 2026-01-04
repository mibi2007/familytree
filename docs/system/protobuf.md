# Protobuf Generation Guide

This document outlines the standard process for generating gRPC and Protocol Buffer code for both the Go backend and the Flutter frontend.

## Prerequisites

- **protoc**: Protocol Buffers compiler.
- **Go Plugins**: `protoc-gen-go` and `protoc-gen-go-grpc`.
- **Dart Plugin**: `protoc_plugin` (Dart package).

## Project Structure

- **Proto Source**: `proto/` (top-level directory).
- **Go Output**: `familytree_go/proto/`.
- **Dart Output**: `familytree_flutter/packages/shared_package/lib/infrastructure/grpc/generated/`.

## Generation for Go

Run from the root directory:

```bash
# Generate all services
sh scripts/generate_go_protos.sh
```

Or manually:

```bash
protoc --go_out=familytree_go --go_opt=paths=source_relative \
    --go-grpc_out=familytree_go --go-grpc_opt=paths=source_relative \
    -I . \
    proto/auth/v1/auth.proto
```

## Generation for Dart

Run from the root directory:

```bash
# Generate all services
sh scripts/generate_dart_protos.sh
```

Or manually:

```bash
# Create the output directory if it doesn't exist
mkdir -p familytree_flutter/packages/shared_package/lib/infrastructure/grpc/generated

# Protoc generation for Dart
protoc --dart_out=grpc:familytree_flutter/packages/shared_package/lib/infrastructure/grpc/generated \
    -I . \
    proto/common/v1/common.proto \
    proto/auth/v1/auth.proto \
    proto/family/v1/family.proto \
    google/protobuf/timestamp.proto \
    google/protobuf/empty.proto
```

## Maintenance

- **NEVER** edit generated files (e.g., `*.pb.dart`, `*.pb.go`).
- If `.proto` files change, always regenerate both Go and Dart code.
- Ensure `protobuf` and `grpc` package versions in `pubspec.yaml` are compatible with the version of `protoc_plugin` used.

## Dart Generated Code Usage

### Messages

- **Creation**: Use the default constructor (e.g., `Foo()`) or factory methods like `Foo.fromBuffer(...)` and `Foo.fromJson(...)`.
- **Manipulation**:
  - `clone()`: Creates a deep copy.
  - `copyWith((t) { ... })`: Creates a writable copy with updates applied.
  - `getDefault()`: Returns a singleton default instance (read-only).

### Fields

Generated names use camel-case (e.g., `foo_bar` becomes `fooBar`).

- **Singular Fields**:
  - `get foo`: Returns the current value or default.
  - `hasFoo()`: Returns `true` if the field is set.
  - `set foo(value)`: Sets the field value.
  - `clearFoo()`: Clears the field value.
  - `ensureFoo()` (Message fields only): Sets the field to an empty instance if unset, and returns it.
- **Repeated Fields**:
  - Returns a mutable `List<T>` (specifically `PbList`). Modifications to the list are reflected in the message.
- **Oneof Fields**:
  - `whichTest()`: Returns an enum indicating which field in the oneof is set.
  - `clearTest()`: Clears the currently set oneof field.

### Enums

- Enums extend `ProtobufEnum`.
- Access values via the static `values` list or `valueOf(int)`.

## References

- [Dart Generated Code Reference](https://protobuf.dev/reference/dart/dart-generated/)
- [Dart Tutorial](https://protobuf.dev/getting-started/darttutorial/)
