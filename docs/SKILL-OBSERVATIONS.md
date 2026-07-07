# Skill-Beobachtungen — [Projektname]

> Gesammelt vom Skill `skill-feedback` (estores-core), abgearbeitet via `/skill-review`.
> Einträge werden nie gelöscht — Status: OFFEN → UMGESETZT / ABGELEHNT.
> Keine Kundendaten in Prinzip-Feldern (Skills sind kundenübergreifend).

---

### Beobachtung 1: CI-Guards mit hashFiles im Job-if schlagen fehl
**Datum:** 2026-07-07 · **Status:** OFFEN
**Skill:** deployment (estores-core)
**Was passiert ist:** web-quality.yml nutzte `hashFiles()` in einem Job-Level-`if`
als Guard. GitHub kennt `hashFiles` dort nicht → jeder PR-Run brach mit
"Run failed / No jobs were run" ab. Der Fehler wurde zunächst als "Guard
funktioniert" fehlinterpretiert; erst der zweite fehlgeschlagene Run zeigte
die echte Ursache. Fix: Detect-Job mit Step-Outputs + `needs`.
**Vorschlag:** Im deployment-Skill eine Regel ergänzen: "GitHub-Actions-Guards
für optionale Jobs immer als Detect-Job mit Step-Outputs bauen — hashFiles
funktioniert nicht in Job-Level-if. Workflow-Änderungen mit einem echten
PR-Run verifizieren, YAML-Validierung reicht nicht."
**Prinzip:** Job-Level-Expressions in GitHub Actions haben eigene Kontext-
regeln; ein Run mit 0 Jobs ist ein Fehler-Signal, kein Erfolgs-Signal.
