# Onboarding: [Projektname]

Willkommen im Team! Diese Anleitung bringt dich in ~4 Stunden auf Stand.

---

## Tag 1 — Verstehen (2–3h)

### Projekt verstehen
- [ ] `docs/DISCOVERY.md` lesen — Was wird gebaut und warum?
- [ ] `docs/ARCHITECTURE.md` lesen — Welche Technologien und warum?
- [ ] `CLAUDE.md` lesen — Wie arbeiten wir?
- [ ] `context/team.md` lesen — Wer ist wer?
- [ ] `decisions/log.md` lesen — Welche wichtigen Entscheidungen wurden getroffen?

### Lokal einrichten
- [ ] Repository klonen
- [ ] `.env.local` anlegen (Credentials von [NAME] holen)
- [ ] Dependencies installieren: `[install-cmd]`
- [ ] Dev-Server starten: `[start-cmd]` — läuft es?
- [ ] Tests ausführen: `[test-cmd]` — alles grün?

### Claude Code einrichten
- [ ] Claude Code installieren: `npm install -g @anthropic-ai/claude-code`
- [ ] `claude /init` ausführen
- [ ] `/plan` ausführen — bekommst du einen sinnvollen Überblick?

---

## Tag 2 — Orientierung (2–3h)

### Codebase kennenlernen
- [ ] Claude Code Prompt ausführen:
  ```
  Erkläre mir die Architektur dieses Projekts anhand des Codes.
  Was sind die wichtigsten Dateien und Patterns?
  Wo fängt man an wenn man [Funktion X] verstehen möchte?
  ```

### Ersten Task bearbeiten
- [ ] Kleinen Task (S-Größe) aus dem Backlog aufnehmen
- [ ] Feature-Branch erstellen: `git checkout -b feature/onboarding-[dein-name]`
- [ ] `/create-feature` Command testen
- [ ] Ersten PR erstellen — zum Kennenlernen des Review-Prozesses

---

## Wichtige Kontakte

| Thema | Ansprechpartner |
|-------|----------------|
| Architektur / Tech-Entscheidungen | [Name] |
| Business Logic / Anforderungen | [Name] |
| Deployment / Infrastruktur | [Name] |
| Fragen zum Projekt allgemein | [Name] |

## Kommunikation
- Sync: [z.B. Montag 10 Uhr Slack Huddle]
- Async: [z.B. Slack #projektname]
- Code Review: [Wer reviewed wen?]

---

## Häufige Fragen

**Wie starte ich den Dev-Server?**
`[start-cmd]`

**Wie führe ich Tests aus?**
`[test-cmd]`

**Wie erstelle ich einen neuen Feature-Branch?**
`git checkout -b feature/[ticket-id]-[beschreibung]`
oder einfach `/create-feature` in Claude Code

**Etwas funktioniert nicht — was tun?**
1. Fehlermeldung kopieren
2. In Claude Code einfügen mit: "Ich bekomme diesen Fehler: [Fehler]. Was bedeutet das?"
3. Bei weiterem Problem: [Name] kontaktieren
