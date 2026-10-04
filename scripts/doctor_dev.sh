#!/usr/bin/env bash
set -u

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GO_MOD_FILE="${ROOT_DIR}/familytree_go/go.mod"

required_failures=0
optional_warnings=0

info() {
  echo "[info] $*"
}

ok() {
  echo "[ok]   $*"
}

warn() {
  echo "[warn] $*"
}

fail() {
  echo "[fail] $*"
}

major_minor() {
  echo "$1" | awk -F. '{ print $1"."$2 }'
}

check_required_cmd() {
  local cmd="$1"
  local hint="$2"

  if command -v "${cmd}" >/dev/null 2>&1; then
    ok "${cmd} found"
  else
    fail "${cmd} missing. ${hint}"
    required_failures=$((required_failures + 1))
  fi
}

check_optional_cmd() {
  local cmd="$1"
  local hint="$2"

  if command -v "${cmd}" >/dev/null 2>&1; then
    ok "${cmd} found"
  else
    warn "${cmd} missing. ${hint}"
    optional_warnings=$((optional_warnings + 1))
  fi
}

check_go_version() {
  if ! command -v go >/dev/null 2>&1; then
    fail "go missing. Run: task setup-go"
    required_failures=$((required_failures + 1))
    return
  fi

  local installed req installed_mm req_mm
  installed="$(go version | awk '{print $3}' | sed 's/^go//')"

  if [[ ! -f "${GO_MOD_FILE}" ]]; then
    warn "Cannot find ${GO_MOD_FILE}; skipping Go version compatibility check"
    optional_warnings=$((optional_warnings + 1))
    return
  fi

  req="$(awk '/^go / { print $2; exit }' "${GO_MOD_FILE}")"
  if [[ -z "${req}" ]]; then
    warn "Could not read required Go version from ${GO_MOD_FILE}"
    optional_warnings=$((optional_warnings + 1))
    return
  fi

  installed_mm="$(major_minor "${installed}")"
  req_mm="$(major_minor "${req}")"

  if [[ "${installed_mm}" == "${req_mm}" ]]; then
    ok "Go version compatible (installed=${installed}, required=${req})"
  else
    fail "Go version mismatch (installed=${installed}, required=${req}). Run: task setup-go"
    required_failures=$((required_failures + 1))
  fi
}

check_protoc_version() {
  if ! command -v protoc >/dev/null 2>&1; then
    fail "protoc missing. Run: task setup-proto"
    required_failures=$((required_failures + 1))
    return
  fi

  local version
  version="$(protoc --version 2>/dev/null || true)"
  if [[ -n "${version}" ]]; then
    ok "${version}"
  else
    ok "protoc found"
  fi
}

check_docker_daemon() {
  if ! command -v docker >/dev/null 2>&1; then
    warn "docker missing. Install Docker Desktop if you need local PostgreSQL"
    optional_warnings=$((optional_warnings + 1))
    return
  fi

  if docker info >/dev/null 2>&1; then
    ok "Docker daemon is running"
  else
    warn "Docker is installed but daemon is not running"
    optional_warnings=$((optional_warnings + 1))
  fi
}

print_path_hints() {
  echo
  info "PATH hints (add to ~/.zshrc or ~/.bashrc if tools are not found):"
  echo '  export PATH="$HOME/.local/go/current/go/bin:$PATH"'
  echo '  export PATH="$HOME/.local/protoc/current/bin:$PATH"'
  echo '  export PATH="$HOME/go/bin:$PATH"'
  echo '  export PATH="$HOME/.pub-cache/bin:$PATH"'
}

main() {
  info "Running Family Tree dev tooling doctor"
  echo

  info "Required tools"
  check_go_version
  check_protoc_version
  check_required_cmd "protoc-gen-go" "Run: task setup-go"
  check_required_cmd "protoc-gen-go-grpc" "Run: task setup-go"
  check_required_cmd "protoc-gen-openapiv2" "Run: task setup-go"

  echo
  info "Recommended tools"
  check_optional_cmd "dart" "Needed for Dart-only workflows"
  check_optional_cmd "flutter" "Needed for Flutter apps and Dart proto generation"
  check_optional_cmd "protoc-gen-dart" "Run: task setup-proto"
  check_optional_cmd "firebase" "Needed for Firebase emulator workflows"
  check_optional_cmd "task" "Install go-task for Taskfile commands"
  check_optional_cmd "grpcwebproxy" "Needed for task run-proxy"
  check_docker_daemon

  echo
  if [[ ${required_failures} -gt 0 ]]; then
    fail "Doctor found ${required_failures} required issue(s) and ${optional_warnings} warning(s)."
    print_path_hints
    exit 1
  fi

  if [[ ${optional_warnings} -gt 0 ]]; then
    warn "Doctor passed required checks with ${optional_warnings} warning(s)."
    print_path_hints
    exit 0
  fi

  ok "Doctor passed: all required and recommended tooling checks are healthy."
}

main "$@"
