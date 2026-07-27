#!/usr/bin/env bash
# Dev-Container-Setup: gitleaks (Binary) + lefthook aktivieren, falls Stack initialisiert.
set -euo pipefail

# 1) gitleaks installieren — offizielles Release-Binary, versions-gepinnt + SHA256-verifiziert
GITLEAKS_VERSION="8.30.1"
if ! command -v gitleaks >/dev/null 2>&1; then
  ARCH="$(uname -m)"
  case "$ARCH" in
    x86_64) ARCH=x64 ;;
    aarch64|arm64) ARCH=arm64 ;;
    *) echo "WARNUNG: Nicht unterstützte Architektur '$ARCH' — gitleaks bitte manuell installieren."; exit 0 ;;
  esac
  TMP="$(mktemp -d)"
  TARBALL="gitleaks_${GITLEAKS_VERSION}_linux_${ARCH}.tar.gz"
  BASE="https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}"
  curl -fsSL -o "$TMP/$TARBALL" "$BASE/$TARBALL"
  curl -fsSL -o "$TMP/checksums.txt" "$BASE/gitleaks_${GITLEAKS_VERSION}_checksums.txt"
  (cd "$TMP" && sha256sum --check --ignore-missing checksums.txt)  # bricht bei Manipulation ab (set -e)
  tar -xzf "$TMP/$TARBALL" -C "$TMP" gitleaks
  sudo install -m 0755 "$TMP/gitleaks" /usr/local/bin/gitleaks
  rm -rf "$TMP"
  echo "gitleaks v${GITLEAKS_VERSION} installiert (Checksum verifiziert)."
fi

# 2) Git-Hooks aktivieren (erst sinnvoll, wenn package.json existiert)
if [ -f package.json ]; then
  npm i -D lefthook && npx lefthook install
else
  echo "Hinweis: Nach /stack-selection Git-Hooks aktivieren: npm i -D lefthook && npx lefthook install"
fi
