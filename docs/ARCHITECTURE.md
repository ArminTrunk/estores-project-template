# Architektur: [Projektname]

> Phase 0.2 — Nach `/stack-selection` automatisch befüllen lassen.
> Basis: docs/DISCOVERY.md + decisions/log.md

---

## Stack-Entscheidung

| Bereich | Gewählt | Alternativen geprüft | Begründung |
|---------|---------|---------------------|-----------|
| Framework | | | |
| Sprache | | | |
| Datenbank | | | |
| ORM / DB-Zugriff | | | |
| Auth | | | |
| Deployment (Prod) | | | |
| Deployment (Staging) | | | |
| CSS / Styling | | | |
| Testing | | | |

## System-Diagramm

```
[Grobe Skizze der Komponenten]

Browser / App
    ↓
Frontend ([Framework])
    ↓
API / Backend
    ↓
Datenbank ([DB])
```

## Datenmodell (Entwurf)

```
[Haupt-Entities und ihre Beziehungen]

Beispiel:
User (1) ──── (n) Order
Order (1) ──── (n) OrderItem
OrderItem (n) ──── (1) Product
```

## Externe Abhängigkeiten

| Service | Zweck | Kosten/Monat | Fallback |
|---------|-------|-------------|---------|
| | | | |

## Risiken

| Risiko | Wahrscheinlichkeit | Impact | Maßnahme |
|--------|-------------------|--------|---------|
| | | | |

---

## Claude Code Prompt zum Befüllen

```
Lies docs/DISCOVERY.md und die Stack-Entscheidung in decisions/log.md.
Fülle docs/ARCHITECTURE.md vollständig aus.
Nutze den systems-analyzer Skill um Risiken zu identifizieren.
Erkläre alle Entscheidungen auf Deutsch in einfacher Sprache.
Markiere klar was noch offen ist.
```
