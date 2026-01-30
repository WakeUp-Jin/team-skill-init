#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"

fix=false
for arg in "$@"; do
  case "$arg" in
    --fix) fix=true ;;
    -h|--help)
      echo "Usage: $(basename "$0") [--fix]"
      exit 0
      ;;
    *)
      echo "Unknown option: $arg" >&2
      echo "Usage: $(basename "$0") [--fix]" >&2
      exit 2
      ;;
  esac
done

cd "$repo_root"

eslint_args=(.)
if $fix; then
  eslint_args+=(--fix)
fi

echo "[lint] npx eslint ${eslint_args[*]}"
npx eslint "${eslint_args[@]}"

if [[ -f "$repo_root/tsconfig.json" ]]; then
  echo "[tsc] npx tsc --noEmit -p tsconfig.json"
  npx tsc --noEmit -p tsconfig.json
else
  echo "[tsc] skipped (tsconfig.json not found)"
fi
