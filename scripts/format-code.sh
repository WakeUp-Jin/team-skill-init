#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"

mode="--write"
for arg in "$@"; do
  case "$arg" in
    --check) mode="--check" ;;
    -h|--help)
      echo "Usage: $(basename "$0") [--check]"
      exit 0
      ;;
    *)
      echo "Unknown option: $arg" >&2
      echo "Usage: $(basename "$0") [--check]" >&2
      exit 2
      ;;
  esac
done

cd "$repo_root"

pattern='src/**/*.{ts,tsx,js,jsx,json,md}'

echo "[format] npx prettier $mode \"$pattern\""
npx prettier $mode "$pattern"
