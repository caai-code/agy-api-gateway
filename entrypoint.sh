#!/bin/bash
set -euo pipefail

mkdir -p "$HOME/.gemini/antigravity-cli"
export PATH="$HOME/.local/bin:$PATH"

if ! command -v agy >/dev/null 2>&1; then
    curl -fsSL https://antigravity.google/cli/install.sh | bash || true
fi

echo "Starting Portable agy Cloud API Gateway v2.3 on port ${PORT:-8080}..."
exec python3 /app/server.py
