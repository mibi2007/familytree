# gRPC & Protocol Buffers

Type-safe contract-first communication.

## Implementation
- **Shared Protobuf**: All `.proto` files reside in the root `proto/` directory.
- **Bi-directional Streaming**: Used for real-time features like the Family Chat.
- **Code Generation**: Automated scripts for Go (`generate_go_protos.sh`) and Dart (`generate_dart_protos.sh`).
- **gRPC-Web**: Support for web integration using Envoy or in-process proxies.
