#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GO_MOD_FILE="${ROOT_DIR}/familytree_go/go.mod"

if [[ ! -f "${GO_MOD_FILE}" ]]; then
  echo "[error] Cannot find go.mod at ${GO_MOD_FILE}"
  exit 1
fi

required_go_version="$(awk '/^go / { print $2; exit }' "${GO_MOD_FILE}")"
if [[ -z "${required_go_version}" ]]; then
  echo "[error] Could not determine required Go version from ${GO_MOD_FILE}"
  exit 1
fi

required_go_major_minor="$(echo "${required_go_version}" | awk -F. '{ print $1"."$2 }')"

installed_go_version=""
installed_go_major_minor=""
if command -v go >/dev/null 2>&1; then
  installed_go_version="$(go version | awk '{print $3}' | sed 's/^go//')"
  installed_go_major_minor="$(echo "${installed_go_version}" | awk -F. '{ print $1"."$2 }')"
fi

install_go_via_homebrew() {
  local version_mm="$1"

  if ! command -v brew >/dev/null 2>&1; then
    return 1
  fi

  local formula="go@${version_mm}"
  local prefix

  echo "[info] Attempting Homebrew install for ${formula}..."
  if brew install "${formula}" >/dev/null 2>&1; then
    prefix="$(brew --prefix "${formula}")"
    export PATH="${prefix}/bin:${PATH}"
    return 0
  fi

  echo "[warn] ${formula} is not available. Falling back to 'brew install go'."
  brew install go
  prefix="$(brew --prefix go)"
  export PATH="${prefix}/bin:${PATH}"
  return 0
}

install_go_via_tarball() {
  local version="$1"
  local os arch machine tarball url tmp_dir install_root version_dir current_link

  os="$(uname -s | tr '[:upper:]' '[:lower:]')"
  case "${os}" in
    darwin|linux) ;;
    *)
      echo "[error] Unsupported OS for automatic tarball install: ${os}"
      return 1
      ;;
  esac

  machine="$(uname -m)"
  case "${machine}" in
    x86_64|amd64) arch="amd64" ;;
    arm64|aarch64) arch="arm64" ;;
    *)
      echo "[error] Unsupported architecture for automatic tarball install: ${machine}"
      return 1
      ;;
  esac

  if command -v curl >/dev/null 2>&1; then
    :
  elif command -v wget >/dev/null 2>&1; then
    :
  else
    echo "[error] Neither curl nor wget is installed. Cannot download Go tarball."
    return 1
  fi

  tarball="go${version}.${os}-${arch}.tar.gz"
  url="https://go.dev/dl/${tarball}"

  install_root="${HOME}/.local/go"
  version_dir="${install_root}/${version}"
  current_link="${install_root}/current"

  echo "[info] Downloading ${url}"
  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir}"' RETURN

  if command -v curl >/dev/null 2>&1; then
    curl -fL "${url}" -o "${tmp_dir}/${tarball}"
  else
    wget -O "${tmp_dir}/${tarball}" "${url}"
  fi

  rm -rf "${version_dir}"
  mkdir -p "${version_dir}"
  tar -C "${version_dir}" -xzf "${tmp_dir}/${tarball}"

  mkdir -p "${install_root}"
  ln -sfn "${version_dir}" "${current_link}"

  export PATH="${current_link}/go/bin:${PATH}"
  echo "[info] Installed Go ${version} at ${version_dir}"
}

needs_install=false
if [[ -z "${installed_go_version}" ]]; then
  echo "[warn] Go is not installed."
  needs_install=true
elif [[ "${installed_go_major_minor}" != "${required_go_major_minor}" ]]; then
  echo "[warn] Installed Go ${installed_go_version} does not match required major.minor ${required_go_major_minor}."
  needs_install=true
else
  echo "[info] Go ${installed_go_version} matches required major.minor ${required_go_major_minor}."
fi

if [[ "${needs_install}" == true ]]; then
  if [[ "$(uname -s)" == "Darwin" ]]; then
    if ! install_go_via_homebrew "${required_go_major_minor}"; then
      echo "[warn] Homebrew path not available. Using Go tarball installer."
      install_go_via_tarball "${required_go_version}"
    fi
  else
    install_go_via_tarball "${required_go_version}"
  fi
fi

if ! command -v go >/dev/null 2>&1; then
  echo "[error] Go is still unavailable in PATH after setup."
  echo "[hint] Add Go to your shell profile and open a new terminal."
  echo '       export PATH="$HOME/.local/go/current/go/bin:$PATH"'
  exit 1
fi

echo "[info] Active $(go version)"

export PATH="$(go env GOPATH)/bin:${PATH}"

echo "[info] Installing Go protobuf tools..."
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest

echo "[info] Downloading backend module dependencies..."
(
  cd "${ROOT_DIR}/familytree_go"
  go mod download
)

echo "[done] Go development setup complete."
echo "[hint] Ensure your PATH includes:"
echo '       export PATH="$HOME/.local/go/current/go/bin:$PATH"'
echo '       export PATH="$HOME/go/bin:$PATH"'
