# Definition of Done

Ein Task/PR ist erst „fertig", wenn ALLE zutreffenden Punkte erfüllt sind.
(Profil-abhängig — irrelevante Zeilen je nach Projekt-Profil ignorieren.)

## Immer
- [ ] Anforderung erfüllt, Akzeptanzkriterien erreicht
- [ ] Code folgt CLAUDE.md + Skills (Naming, Funktionsgröße, Error-Handling)
- [ ] Keine Debug-Ausgaben / auskommentierter Code / Magic Numbers
- [ ] Typecheck + Lint grün
- [ ] Tests für neue Logik (Happy Path + Edge + Error), Suite grün
- [ ] CHANGELOG.md [Unreleased] aktualisiert
- [ ] Conventional-Commit-Message
- [ ] Selbst-Review / `/pr-review` ohne kritische Findings

## Bei Personendaten (internal-tool, public-app-pii)
- [ ] `/privacy-check` ohne 🔴 — Rechtsgrundlage + Minimierung geprüft
- [ ] Keine PII in Logs/Errors/Analytics
- [ ] COMPLIANCE.md aktualisiert

## Bei öffentlichen Web-Seiten (marketing, cms, public-pii)
- [ ] `/a11y-check` ohne 🔴 (WCAG 2.1 AA)
- [ ] Core Web Vitals im Budget, Meta/OG/Sitemap gepflegt

## Bei sicherheitsrelevanten Änderungen
- [ ] `/security-check` ohne 🔴
