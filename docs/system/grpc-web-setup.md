# gRPC-Web Setup Guide

## Problem
Flutter Web apps cannot directly connect to gRPC servers. They need a **grpc-web proxy** that translates grpc-web HTTP requests to gRPC.

## Current Setup
- **Go Backend (gRPC)**: Runs on `localhost:50051`
- **Flutter Web**: Expects grpc-web on `localhost:9090`

## Solution: grpcwebproxy

We use `grpcwebproxy` (a Go-based proxy) because it is lightweight and does not require Docker on Windows.

### Installation
If you don't have it yet, install it via Go:
```bash
go install github.com/improbable-eng/grpc-web/go/grpcwebproxy@latest
```

### Running the Proxy
You can start the proxy using the Taskfile:
```bash
task run-proxy
```
This runs:
`grpcwebproxy --backend_addr=localhost:50051 --run_tls_server=false --allow_all_origins --server_http_debug_port=9090`

## Verification
Once the proxy is running, test with:
```bash
curl http://localhost:9090/
```
You should see a response from the proxy (likely a 404 or similar, but not "connection refused").

## Dev Workflow
When developing locally, run these in separate terminals:
1. `task run-be` - Start Go backend (port 50051)
2. `task run-proxy` - Start grpc-web proxy (port 9090)
3. `task run-fe-admin` - Start Flutter admin app (port 8081)
