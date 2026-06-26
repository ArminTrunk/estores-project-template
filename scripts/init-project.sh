#!/usr/bin/env bash
# Projekt aus diesem Template initialisieren.
# Verwendung:  ./scripts/init-project.sh "Mein Projektname"
set -euo pipefail

NAME="${1:-}"
if [[ -z "$NAME" ]]; then
  read -rp "Projektname: " NAME
fi
[[ -z "$NAME" ]] && { echo "❌ Kein Projektname angegeben."; exit 1; }

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "▶ Initialisiere Projekt: $NAME"

# 1) Projekt-README aus Skelett erzeugen (ersetzt Template-README)
if [[ -f templates/README.project.md ]]; then
  cp templates/README.project.md README.md
fi

# 2) Platzhalter [Projektname] in Kern-Dateien ersetzen
TARGETS=(README.md CLAUDE.md AGENTS.md)
while IFS= read -r f; do TARGETS+=("$f"); done < <(find docs decisions -name '*.md' 2>/dev/null)
for f in "${TARGETS[@]}"; do
  [[ -f "$f" ]] && sed -i "s/\[Projektname\]/$NAME/g" "$f" || true
done

# 3) Persönliche Dateien anlegen (gitignored)
mkdir -p context
[[ -f .env.local ]] || { [[ -f .env.example ]] && cp .env.example .env.local; }
[[ -f context/current-priorities.md ]] || echo "# Aktuelle Prioritäten — $NAME" > context/current-priorities.md

# 4) Template-only Dateien entfernen (dürfen im Projekt nicht auftauchen)
rm -f TEMPLATE-USAGE.md UPGRADE-v2.md .claude/CHANGELOG-UPGRADE.md templates/README.project.md

echo "✅ Fertig. Nächste Schritte:"
echo "   1) npm i -D lefthook && npx lefthook install   (Git-Hooks)"
echo "   2) claude /init"
echo "   3) /project-type   → Profil   →   /stack-selection   →   /plan"

# 5) Skript entfernt sich selbst (Einmal-Bootstrap)
rm -f "$ROOT/scripts/init-project.sh"
rmdir "$ROOT/scripts" 2>/dev/null || true
