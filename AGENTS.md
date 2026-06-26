# AGENTS.md — [Projektname]

## Für KI-Agenten die auf diesem Repo arbeiten

### Pflicht vor jeder Aktion
1. CLAUDE.md lesen
2. docs/ARCHITECTURE.md lesen
3. context/current-priorities.md lesen
4. decisions/log.md auf relevante Entscheidungen prüfen
5. CLAUDE.md → Projekt-Profil + docs/COMPLIANCE.md beachten (Pflicht-Skills je Profil)

### Was du NICHT tun darfst
- Direkt auf `main` oder `staging` pushen
- Datenbankmigrationen ohne explizite Bestätigung ausführen
- .env Dateien erstellen oder modifizieren
- Dependencies hinzufügen oder entfernen ohne Bestätigung
- Production-Deploys triggern
- Personendaten (PII) in Logs/Errors/URLs/Analytics schreiben
- Tracking vor Einwilligung laden

### Branching
Alle Änderungen auf Feature-Branch: `feature/[beschreibung]`

### Commit-Format
`type(scope): beschreibung` — Conventional Commits

Typen: feat / fix / docs / style / refactor / test / chore

### Kommunikation
- Immer auf Deutsch antworten
- Vor größeren Änderungen: Plan erklären und Bestätigung abwarten
- Technische Begriffe immer kurz erklären
- Am Ende jeder Session: kurze Zusammenfassung
