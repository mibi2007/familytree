---
description: Install/verify protoc and protobuf codegen plugins for Go + Flutter/Dart
---

This workflow prepares protobuf tooling used by both backend and Flutter code generation.

## 1) Run setup script

```bash
./scripts/setup_proto_dev.sh
```

What it does:
- Installs `protoc` (Homebrew/apt when possible, fallback zip install)
- Ensures Go plugins:
  - `protoc-gen-go`
  - `protoc-gen-go-grpc`
  - `protoc-gen-openapiv2`
- Ensures Dart plugin:
  - `protoc-gen-dart`

## 2) Verify

```bash
protoc --version
protoc-gen-go --version || true
protoc-gen-go-grpc --version || true
protoc-gen-openapiv2 --help >/dev/null || true
protoc-gen-dart --version || true
```

## 3) Run tooling doctor

```bash
task doctor
```

## 4) Generate protos

```bash
./scripts/generate_go_protos.sh
./scripts/generate_dart_protos.sh
```

## PATH reminder

If a new terminal cannot find tools, add to shell profile (`~/.zshrc` or `~/.bashrc`):

```bash
export PATH="$HOME/.local/protoc/current/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.pub-cache/bin:$PATH"
```
