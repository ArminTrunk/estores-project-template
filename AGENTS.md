# AGENTS.md — [Projektname]

> **Einzige Quelle** für Verhaltensregeln aller KI-Agenten (Claude Code, Cursor, …).
> CLAUDE.md importiert diese Datei — Regeln NUR hier pflegen, nie doppelt.

## Pflicht vor jeder Aktion
1. CLAUDE.md lesen (Projekt-Profil, Stack, Befehle)
2. docs/ARCHITECTURE.md lesen
3. context/current-priorities.md lesen
4. docs/BACKLOG.md prüfen (offene Tasks + Abhängigkeiten)
5. decisions/log.md auf relevante Entscheidungen prüfen
6. docs/COMPLIANCE.md beachten (Pflicht-Skills je Profil)

## Was du NICHT tun darfst
> Diese Regeln werden zusätzlich technisch erzwungen (Plugin-Hooks,
> `.claude/settings.json` → permissions.deny, lefthook, CI).

- Direkt auf `main` oder `staging` pushen
- Datenbankmigrationen ohne explizite Bestätigung ausführen
- `.env`-Dateien lesen, erstellen oder modifizieren (Ausnahme: `.env.example`)
  — Hinweis: die Deny-Liste in `.claude/settings.json` zählt Varianten auf (Negation ist
  dort nicht möglich); nutzt ein neuer Stack weitere `.env.<mode>`-Namen, dort nachtragen
- Dependencies hinzufügen oder entfernen ohne Bestätigung
- Production-Deploys triggern (nur via `/release`)
- `console.log` / `dd()` / `print()` in Production-Code committen
- Personendaten (PII) in Logs, Error-Messages, URLs oder Analytics-Events schreiben
- Tracking/Drittanbieter-Scripts vor Einwilligung laden
- UI bauen, die nur per Maus bedienbar ist (Tastatur + Semantik Pflicht bei Web-Profilen)
- Code schreiben ohne vorher den Plan erklärt zu haben

## Backlog
- Einzige Task-Quelle: `docs/BACKLOG.md` (committed, Format siehe Dateikopf)
- Vor neuen Features: dort auf Abhängigkeiten prüfen; nach Abschluss Status aktualisieren

## Branching
- `main` → Production (protected) · `staging` → Staging · `develop` → Entwicklung
- Alle Änderungen auf Feature-Branch: `feature/[ticket-id]-[name]`
- Hotfixes: `hotfix/[ticket-id]-[name]`

## Commit-Format
`type(scope): beschreibung` — Conventional Commits
Typen: feat / fix / docs / style / refactor / perf / test / build / ci / chore

## Kommunikation
- Immer auf Deutsch antworten (Code-Kommentare auf Englisch)
- Vor größeren Änderungen: Plan erklären und Bestätigung abwarten
- Technische Begriffe immer kurz erklären (Nutzer ist Nicht-Entwickler)
- Bei Unklarheiten: fragen statt raten
- Am Ende jeder Session: kurze Zusammenfassung (gemacht / offen / nächster Schritt)
