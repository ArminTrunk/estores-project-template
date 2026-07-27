#!/usr/bin/env bash
# Dev-Container-Setup: gitleaks (Binary) + lefthook aktivieren, falls Stack initialisiert.
set -euo pipefail

# 1) gitleaks installieren — offizielles Release-Binary, versions-gepinnt + SHA256-verifiziert
GITLEAKS_VERSION="8.30.1"
# Subshell-Funktion: der EXIT-Trap feuert beim Verlassen der Subshell —
# Cleanup läuft damit in Erfolgs- UND Abbruchpfad, ohne den globalen Scope zu berühren.
install_gitleaks() (
  ARCH="$(uname -m)"
  case "$ARCH" in
    x86_64) ARCH=x64 ;;
    aarch64|arm64) ARCH=arm64 ;;
    *) echo "WARNUNG: Nicht unterstützte Architektur '$ARCH' — gitleaks bitte manuell installieren." >&2; exit 0 ;;
  esac
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  TARBALL="gitleaks_${GITLEAKS_VERSION}_linux_${ARCH}.tar.gz"
  BASE="https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}"
  curl -fsSL -o "$TMP/$TARBALL" "$BASE/$TARBALL"
  curl -fsSL -o "$TMP/checksums.txt" "$BASE/gitleaks_${GITLEAKS_VERSION}_checksums.txt"
  # stellt sicher, dass das Tarball dem veröffentlichten Hash entspricht (bricht unter set -e ab)
  (cd "$TMP" && sha256sum --check --ignore-missing checksums.txt)
  tar -xzf "$TMP/$TARBALL" -C "$TMP" gitleaks
  sudo install -m 0755 "$TMP/gitleaks" /usr/local/bin/gitleaks
  echo "gitleaks v${GITLEAKS_VERSION} installiert (Checksum verifiziert)."
)
if ! command -v gitleaks >/dev/null 2>&1; then
  install_gitleaks
fi

# 2) Git-Hooks aktivieren (erst sinnvoll, wenn package.json existiert)
if [ -f package.json ]; then
  npm i -D lefthook && npx lefthook install
else
  echo "Hinweis: Nach /stack-selection Git-Hooks aktivieren: npm i -D lefthook && npx lefthook install"
fi
