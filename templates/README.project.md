# [Projektname]

[Ein bis zwei Sätze: Was ist dieses Projekt und für wen?]

## Überblick
- **Zweck:** [Welches Problem löst es?]
- **Profil:** [marketing-site / headless-cms-site / internal-tool / public-app-pii]
- **Status:** [in Entwicklung / Beta / Production]

## Stack
- **Framework:** [z.B. Astro 4 / Next.js / Laravel]
- **Sprache:** [TypeScript / PHP / Python]
- **Datenbank:** [PostgreSQL / Supabase / …]
- **Hosting:** [Vercel / Coolify / …]
> Details und Begründung: `docs/ARCHITECTURE.md`

## Lokal starten
```bash
cp .env.example .env.local      # Secrets eintragen
[install-cmd]                   # z.B. npm install
[start-cmd]                     # z.B. npm run dev
[test-cmd]                      # z.B. npm test
```

## Projektstruktur (Auszug)
```
src/            → Anwendungscode
docs/           → DISCOVERY, ARCHITECTURE, ROADMAP, COMPLIANCE
decisions/      → Entscheidungs-Log + ADRs
tests/          → unit / integration / e2e
```

## Entwicklung
- Branching: `feature/[ticket-id]-[name]` → PR → `develop` → `staging` → `main`
- Neues Feature in Claude Code: `/create-feature`
- Vor dem Commit: `/local-review`
- „Fertig" heißt: `templates/definition-of-done.md` erfüllt

## Deployment
- Staging: `/deploy-staging` · Production: `/release`

## Dokumentation
- Produkt & Scope → `docs/DISCOVERY.md`
- Architektur → `docs/ARCHITECTURE.md`
- Roadmap → `docs/ROADMAP.md`
- Compliance (DSGVO/BFSG) → `docs/COMPLIANCE.md`
- Entscheidungen → `decisions/log.md`

---
*[Projektname] — [Jahr]*
