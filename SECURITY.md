# Security Policy

## Sicherheitslücke melden
Bitte **keine** öffentlichen Issues für Sicherheitslücken.
Melde sie vertraulich an: [security@estores.de] (anpassen).

Wir bestätigen den Eingang innerhalb von 48h und halten dich über den Status auf dem Laufenden.

## Geltungsbereich
- Code in diesem Repository und seine Deployments
- Abhängigkeiten werden über Dependabot + CI-Audit überwacht

## Unsere Maßnahmen (Auszug)
- Secret-Scanning (TruffleHog) + Dependency-Audit in CI
- Lokale Pre-Commit-Hooks (lefthook) gegen Secrets & gefährliche Befehle
- Security-Header, Input-Validierung, Auth/RBAC (siehe `.claude/skills/security.md`)
