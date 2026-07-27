#!/usr/bin/env bash
# Dev-Container-Setup: gitleaks (Binary) + lefthook aktivieren, falls Stack initialisiert.
set -euo pipefail

# 1) gitleaks installieren (versioniert + Checksum-los bewusst vermieden: offizielles Release-Binary)
GITLEAKS_VERSION="8.30.1"
if ! command -v gitleaks >/dev/null 2>&1; then
  ARCH="$(uname -m)"; case "$ARCH" in x86_64) ARCH=x64 ;; aarch64|arm64) ARCH=arm64 ;; esac
  TMP="$(mktemp -d)"
  curl -fsSL -o "$TMP/gitleaks.tar.gz" \
    "https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}/gitleaks_${GITLEAKS_VERSION}_linux_${ARCH}.tar.gz"
  tar -xzf "$TMP/gitleaks.tar.gz" -C "$TMP" gitleaks
  sudo install -m 0755 "$TMP/gitleaks" /usr/local/bin/gitleaks
  rm -rf "$TMP"
  echo "gitleaks v${GITLEAKS_VERSION} installiert."
fi

# 2) Git-Hooks aktivieren (erst sinnvoll, wenn package.json existiert)
if [ -f package.json ]; then
  npm i -D lefthook && npx lefthook install
else
  echo "Hinweis: Nach /stack-selection Git-Hooks aktivieren: npm i -D lefthook && npx lefthook install"
fi
