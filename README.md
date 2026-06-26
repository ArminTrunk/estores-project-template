# EStores Project Template

Claude-Code-Startpunkt für alle EStores-Projekttypen: Websites (mit/ohne Headless-CMS),
interne Tools und öffentliche Tools mit Personendaten. Ein Template, profilgesteuert.

## Verwenden

1. Oben auf **„Use this template"** → eigenes Repo erstellen → klonen.
2. Projekt initialisieren (ersetzt diese README durch eine Projekt-README und
   entfernt die Template-Mechanik):
   ```bash
   ./scripts/init-project.sh "Mein Projektname"
   ```
3. Beim ersten Öffnen in Claude Code Ordner vertrauen → der **estores-Marketplace**
   und das Plugin `estores-core` werden installiert (Fallback: `.claude/PLUGINS.md`).
4. Weiter nach **`TEMPLATE-USAGE.md`** — dort steht die vollständige Reihenfolge,
   alle Commands, Profile, Hooks, CI und Plugin-Optionen.

> Ohne Schritt 2 bleibt die Template-Beschreibung im Projekt stehen — `init-project`
> sorgt dafür, dass das neue Repo nur das *Projekt* beschreibt.

---
*EStores GmbH / Syntegro*
