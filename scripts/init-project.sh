#!/usr/bin/env bash
# Projekt aus diesem Template initialisieren.
# Verwendung:  ./scripts/init-project.sh "Mein Projektname"
set -euo pipefail

NAME="${1:-}"
if [[ -z "$NAME" ]]; then
  read -rp "Projektname: " NAME
fi
[[ -z "$NAME" ]] && { echo "FEHLER: Kein Projektname angegeben."; exit 1; }

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "Initialisiere Projekt: $NAME"

# 1) Projekt-README aus Skelett erzeugen (ersetzt Template-README)
if [[ -f templates/README.project.md ]]; then
  cp templates/README.project.md README.md
fi

# 2) Platzhalter [Projektname] ersetzen — portabel für macOS (BSD sed) UND Linux (GNU sed).
#    Sonderzeichen im Namen (& / \) für sed escapen, sonst zerstören sie die Ersetzung.
SAFE_NAME="$(printf '%s' "$NAME" | sed -e 's/[\/&\\]/\\&/g')"
TARGETS=(README.md CLAUDE.md AGENTS.md)
while IFS= read -r f; do TARGETS+=("$f"); done < <(find docs decisions -name '*.md' 2>/dev/null)
for f in "${TARGETS[@]}"; do
  if [[ -f "$f" ]]; then
    sed -i.initbak "s/\[Projektname\]/$SAFE_NAME/g" "$f" && rm -f "$f.initbak"
  fi
done

# 3) Persönliche Dateien anlegen (gitignored)
mkdir -p context
[[ -f .env.local ]] || { [[ -f .env.example ]] && cp .env.example .env.local; }
[[ -f context/current-priorities.md ]] || echo "# Aktuelle Prioritäten — $NAME" > context/current-priorities.md

# 4) Template-only Dateien entfernen (dürfen im Projekt nicht auftauchen)
rm -f TEMPLATE-USAGE.md UPGRADE-v2.md templates/README.project.md

# 5) Optional: GitHub-Branch-Schutz einrichten (Ruleset aus .github/rulesets/)
#    Braucht: gh CLI eingeloggt + Repo bereits auf GitHub gepusht.
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1 && [[ -f .github/rulesets/branch-protection.json ]]; then
  REPO="$(gh repo view --json nameWithOwner --jq .nameWithOwner 2>/dev/null || true)"
  if [[ -n "$REPO" ]]; then
    read -rp "Branch-Schutz (Ruleset) für $REPO jetzt einrichten? [j/N] " ANTWORT
    if [[ "$ANTWORT" =~ ^[jJyY]$ ]]; then
      gh api "repos/$REPO/rulesets" --method POST --input .github/rulesets/branch-protection.json \
        && echo "Ruleset 'Schutz main + staging' aktiv." \
        || echo "WARNUNG: Ruleset konnte nicht angelegt werden (Rechte? Branches vorhanden?). Manuell: GitHub → Settings → Rules → Import."
    fi
  fi
fi

echo "Fertig. Nächste Schritte:"
echo "   1) gitleaks installieren: brew install gitleaks   (Secret-Scan für Git-Hooks)"
echo "   2) npm i -D lefthook && npx lefthook install      (Git-Hooks)"
echo "   3) claude /init"
echo "   4) /project-type   -> Profil   ->   /stack-selection   ->   /plan"

# 6) Skript entfernt sich selbst (Einmal-Bootstrap)
rm -f "$ROOT/scripts/init-project.sh"
rmdir "$ROOT/scripts" 2>/dev/null || true
