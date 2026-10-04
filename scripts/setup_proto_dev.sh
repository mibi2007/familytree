#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROTOC_VERSION="29.3"

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

install_protoc_via_homebrew() {
  if ! has_cmd brew; then
    return 1
  fi

  echo "[info] Installing protobuf via Homebrew..."
  brew install protobuf
  return 0
}

install_protoc_via_apt() {
  if ! has_cmd apt-get; then
    return 1
  fi

  if has_cmd sudo && sudo -n true >/dev/null 2>&1; then
    echo "[info] Installing protobuf-compiler via apt..."
    sudo apt-get update
    sudo apt-get install -y protobuf-compiler
    return 0
  fi

  return 1
}

install_protoc_via_zip() {
  local os machine arch zip_name url tmp_dir install_root version_dir current_link

  os="$(uname -s | tr '[:upper:]' '[:lower:]')"
  machine="$(uname -m)"

  case "${machine}" in
    x86_64|amd64) arch="x86_64" ;;
    arm64|aarch64) arch="aarch_64" ;;
    *)
      echo "[error] Unsupported architecture for protoc zip install: ${machine}"
      return 1
      ;;
  esac

  case "${os}" in
    darwin|linux) ;;
    *)
      echo "[error] Unsupported OS for protoc zip install: ${os}"
      return 1
      ;;
  esac

  if ! has_cmd curl && ! has_cmd wget; then
    echo "[error] Need curl or wget to download protoc."
    return 1
  fi

  if ! has_cmd unzip; then
    echo "[error] Need unzip to install protoc from zip archive."
    return 1
  fi

  zip_name="protoc-${PROTOC_VERSION}-${os}-${arch}.zip"
  url="https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/${zip_name}"

  install_root="${HOME}/.local/protoc"
  version_dir="${install_root}/${PROTOC_VERSION}"
  current_link="${install_root}/current"

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir}"' RETURN

  echo "[info] Downloading ${url}"
  if has_cmd curl; then
    curl -fL "${url}" -o "${tmp_dir}/${zip_name}"
  else
    wget -O "${tmp_dir}/${zip_name}" "${url}"
  fi

  rm -rf "${version_dir}"
  mkdir -p "${version_dir}"
  unzip -q "${tmp_dir}/${zip_name}" -d "${version_dir}"

  mkdir -p "${install_root}"
  ln -sfn "${version_dir}" "${current_link}"

  export PATH="${current_link}/bin:${PATH}"
  echo "[info] Installed protoc ${PROTOC_VERSION} into ${version_dir}"
}

ensure_protoc() {
  if has_cmd protoc; then
    echo "[info] Found $(protoc --version)"
    return 0
  fi

  echo "[warn] protoc is not installed."

  if [[ "$(uname -s)" == "Darwin" ]] && install_protoc_via_homebrew; then
    return 0
  fi

  if [[ "$(uname -s)" == "Linux" ]] && install_protoc_via_apt; then
    return 0
  fi

  install_protoc_via_zip
}

ensure_go_plugin() {
  local plugin_name install_target
  plugin_name="$1"
  install_target="$2"

  if has_cmd "${plugin_name}"; then
    echo "[info] Found ${plugin_name}"
    return 0
  fi

  if ! has_cmd go; then
    echo "[error] ${plugin_name} missing and Go is not installed. Run ./scripts/setup_go_dev.sh first."
    return 1
  fi

  echo "[info] Installing ${plugin_name}..."
  go install "${install_target}"
}

ensure_dart_plugin() {
  if has_cmd protoc-gen-dart; then
    echo "[info] Found protoc-gen-dart"
    return 0
  fi

  if has_cmd dart; then
    echo "[info] Installing protoc-gen-dart via dart pub..."
    dart pub global activate protoc_plugin
  elif has_cmd flutter; then
    echo "[info] Installing protoc-gen-dart via flutter pub..."
    flutter pub global activate protoc_plugin
  else
    echo "[warn] protoc-gen-dart missing and neither dart nor flutter is available."
    echo "[hint] Install Flutter/Dart, then run: dart pub global activate protoc_plugin"
    return 1
  fi

  export PATH="${HOME}/.pub-cache/bin:${PATH}"
}

main() {
  ensure_protoc

  export PATH="$(go env GOPATH 2>/dev/null || echo "${HOME}/go")/bin:${PATH}"
  ensure_go_plugin "protoc-gen-go" "google.golang.org/protobuf/cmd/protoc-gen-go@latest"
  ensure_go_plugin "protoc-gen-go-grpc" "google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest"
  ensure_go_plugin "protoc-gen-openapiv2" "github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest"

  if ! ensure_dart_plugin; then
    echo "[warn] Dart plugin setup incomplete (Go proto generation still works)."
  fi

  echo "[done] Protobuf development toolchain is ready."
  echo "[hint] Ensure your PATH contains:"
  echo '       export PATH="$HOME/.local/protoc/current/bin:$PATH"'
  echo '       export PATH="$HOME/go/bin:$PATH"'
  echo '       export PATH="$HOME/.pub-cache/bin:$PATH"'
}

main "$@"
