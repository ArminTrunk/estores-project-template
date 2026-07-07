# [Projektname] — Claude Code Kontext

## Projekt-Profil
> Per `/project-type` gesetzt. Bestimmt Pflicht-Skills und Compliance-Checklisten.

- **Profil:** [marketing-site / headless-cms-site / internal-tool / public-app-pii]
- **Verarbeitet Personendaten:** [ja / teilweise / nein]
- **Pflicht-Skills:** [aus Profil-Matrix in /project-type]
- **Compliance:** siehe `docs/COMPLIANCE.md` (+ `docs/THREAT-MODEL.md` bei public-app-pii)
- **Claude-Bausteine:** Skills, Agents, Commands, Hooks und Verhaltens-Rules kommen aus den
  **estores-Plugins** (Marketplace, via `.claude/settings.json`) — nicht lokal im Repo. Siehe `.claude/PLUGINS.md`.

## Verhaltensregeln (einzige Quelle: AGENTS.md)
@AGENTS.md

## Projekt-Überblick
- **Produkt**: [Kurzbeschreibung — was macht dieses Produkt?]
- **Stack**: [z.B. Next.js 15 / Laravel 11 / Vue 3 / FastAPI / React Native]
- **Sprache(n)**: [TypeScript / PHP / Python / Kotlin / etc.]
- **CSS/Styling**: [Tailwind / SCSS / styled-components / Bootstrap / etc.]
- **Datenbank**: [PostgreSQL / MySQL / MongoDB / Supabase / etc.]
- **ORM**: [Prisma / Eloquent / SQLAlchemy / Drizzle / etc.]
- **Deployment**: [z.B. Vercel (Prod) + Coolify (Staging) / Hetzner / Railway / etc.]
- **Team**: [Namen / Rollen]

## Wichtige Befehle
```bash
# An den tatsächlichen Stack anpassen:
[start-cmd]      # Dev-Server starten  (z.B. npm run dev / php artisan serve / uvicorn)
[build-cmd]      # Production Build    (z.B. npm run build / composer install --no-dev)
[test-cmd]       # Tests ausführen     (z.B. npm test / php artisan test / pytest)
[lint-cmd]       # Linting             (z.B. npm run lint / ./vendor/bin/pint)
[typecheck-cmd]  # Typ-Prüfung         (z.B. npx tsc --noEmit / mypy .)
[migrate-cmd]    # DB-Migration        (z.B. npx prisma migrate / php artisan migrate)
```

## Code-Konventionen
- Sprache: [TypeScript strict / PHP 8.3 / Python 3.12 / etc.] — kein untypisiertes ohne Kommentar
- Komponenten/Module: [Funktional / Klassen-basiert / etc.]
- Naming: [camelCase / snake_case / PascalCase — je nach Sprache und Framework-Standard]
- Imports: [Absolute Pfade via `@/` / PSR-4 Autoloading / etc.]
- CSS/Styling: [Tailwind-first / BEM / CSS Modules / etc.]
- Error Handling: Immer explizit — keine stillen Failures
- Tests: Für jede neue Funktion mind. ein Unit-Test

## Architektur-Entscheidungen
- State Management: [Zustand / Pinia / Redux / etc. oder keins]
- Datenabruf: [Server Components / React Query / SWR / Axios / etc.]
- Auth: [Auth.js / Clerk / Laravel Sanctum / JWT / etc.]
- DB-Zugriff: [Prisma / Eloquent / SQLAlchemy / raw SQL / etc.]
- API-Layer: [tRPC / REST / GraphQL / etc.]

## Aktuelle Prioritäten & Backlog
- Sprint-Fokus (persönlich, gitignored):
@context/current-priorities.md
- Team-Backlog: `docs/BACKLOG.md` — einzige Task-Quelle, Status dort pflegen
