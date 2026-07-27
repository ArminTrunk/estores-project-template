# Security Policy

## Sicherheitslücke melden
Bitte **keine** öffentlichen Issues für Sicherheitslücken.
Melde sie vertraulich an: **info@estores.de**.

Wir bestätigen den Eingang innerhalb von 48h und halten dich über den Status auf dem Laufenden.

## Geltungsbereich
- Code in diesem Repository und seine Deployments
- Abhängigkeiten werden über Dependabot + CI-Audit überwacht

## Unsere Maßnahmen (Auszug)
- Secret-Scanning (gitleaks) + Dependency-Audit + CodeQL in CI
- Lokale Pre-Commit-Hooks (lefthook) gegen Secrets & gefährliche Befehle
- Security-Header, Input-Validierung, Auth/RBAC (siehe Skill `security` im estores-core-Plugin)
