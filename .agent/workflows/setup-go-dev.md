---
description: Install/verify Go toolchain and protobuf plugins for local Family Tree backend development
---

This workflow sets up Go for local backend development and Go-side protobuf plugins.

## 1) Run setup script

```bash
./scripts/setup_go_dev.sh
```

What it does:
- Reads required Go version from `familytree_go/go.mod`
- Installs/updates Go if missing or mismatched (prefers Homebrew on macOS)
- Installs Go protobuf plugins:
  - `protoc-gen-go`
  - `protoc-gen-go-grpc`
  - `protoc-gen-openapiv2`
- Downloads backend dependencies (`go mod download`)

## 2) Verify installation

```bash
go version
protoc-gen-go --version || true
protoc-gen-go-grpc --version || true
```

## 3) Verify backend build/test

```bash
cd familytree_go
go test ./...
```

## 4) Setup protoc + Dart plugin (recommended)

```bash
./scripts/setup_proto_dev.sh
```

(or follow `.agent/workflows/setup-proto-dev.md`)

## 5) Run tooling doctor

```bash
task doctor
```

## 6) Generate Go protos

From project root:

```bash
./scripts/generate_go_protos.sh
```

## PATH reminder

If a new terminal cannot find Go tools, add these lines to your shell profile (`~/.zshrc` or `~/.bashrc`):

```bash
export PATH="$HOME/.local/go/current/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
```
