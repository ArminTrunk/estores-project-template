# Template Upgrade v2 — Best-in-Class (Juni 2026)

Ziel: EIN Template für alle Projekt-Typen (Websites, Headless-CMS, interne Tools,
öffentliche Tools mit Personendaten) — ohne Ballast, gesteuert über **Profile**.

## 🎯 Neu: Projekt-Profile (`/project-type`)
Vier Profile aktivieren je nur die passenden Pflicht-Skills + Compliance-Checklisten:
`marketing-site` · `headless-cms-site` · `internal-tool` · `public-app-pii`.
Profil wird in CLAUDE.md verankert und steuert COMPLIANCE.md / THREAT-MODEL.md.

## ➕ Neue Skills (5)
- `privacy-dsgvo.md` — DSGVO: Rechtsgrundlagen, Minimierung, Consent, Betroffenenrechte,
  Löschkonzept, AVV, TOMs, Verzeichnis, Datenpannen. (Pflicht bei PII)
- `accessibility.md` — BFSG/WCAG 2.1 AA: Semantik, Tastatur, Kontrast, Formulare, Testing.
- `seo-performance.md` — Meta/OG/Canonical, Sitemap, JSON-LD, Core Web Vitals, Bild-Opt.
- `headless-cms.md` — Content-Modell, Preview, Webhook-Revalidation, i18n, Robustheit.
- `observability.md` — strukturiertes + PII-sicheres Logging, Sentry-Scrubbing, Healthcheck, Audit-Log.

## ➕ Neuer Agent (1)
- `compliance-auditor.md` — auditiert DSGVO + Barrierefreiheit (Wissen aus den Skills).

## ➕ Neue Commands (3)
- `project-type.md` (Profil-Selektor) · `privacy-check.md` · `a11y-check.md`
  (parallel zum bestehenden `security-check.md`).

## ➕ Neue Docs / Templates
- `docs/COMPLIANCE.md` — profil-gesteuerte Checkliste (DSGVO + BFSG + Security + SEO).
- `docs/THREAT-MODEL.md` — Datenklassifizierung + STRIDE-lite (Pflicht bei public-app-pii).
- `templates/definition-of-done.md` — profil-abhängige DoD.

## ➕ GitHub-Hygiene
- `PULL_REQUEST_TEMPLATE.md`, `ISSUE_TEMPLATE/*`, `dependabot.yml`, `CODEOWNERS`
- `workflows/web-quality.yml` — Lighthouse-Budgets (CWV/SEO/A11y) + pa11y
- `.lighthouserc.json`, `.pa11yci.json`

## ➕ Root-Tooling
- `SECURITY.md` (Responsible Disclosure)
- `.editorconfig`
- `lefthook.yml` — echte Git-Hooks (Secrets via gitleaks, Lint, Typecheck,
  Conventional-Commit-Enforcement) — greifen auch ohne Claude Code
- `.mcp.json.example` — übliche Server (Supabase/Storyblok/GitHub/DataForSEO), ohne Tokens

## 🔧 Bestehendes verbessert
- `rules/model-selection.md` → Opus **4.8** / Sonnet 4.6 / Haiku 4.5 (war 4.6).
- `scripts/check-dangerous-commands.sh` → +DELETE/UPDATE ohne WHERE, TRUNCATE,
  prisma/supabase reset, force-push auch auf staging, curl|sh, chmod 777.
- `scripts/check-env-leak.sh` → +AWS/Google/Stripe/GitHub/JWT/Private-Key/Supabase-service_role.
- `.gitignore` → +Astro/Vercel/Turbo/SvelteKit/Supabase/Lighthouse/pa11y.
- `CLAUDE.md` → Profil-Block + PII/Consent/A11y-Guardrails.
- `AGENTS.md` → Profil + Compliance-Pflichten.
- `README.md` → Profile dokumentiert, `/project-type` im Setup, dangling Ref entfernt.

## Setup nach Übernahme
```
npm i -D lefthook && npx lefthook install   # Git-Hooks aktivieren
cp .mcp.json.example .mcp.json              # dann echte Tokens via Env
/project-type                                # Profil wählen → Rest richtet sich danach
```

## Bewusst NICHT gemacht (deine Entscheidung)
- Reasoning-Skills (critical-evaluator / decision-architect / systems-analyzer) NICHT
  zusammengeführt — verschiedene Trigger.
- Kein konkreter Stack erzwungen — `stack.md` bleibt nach `/stack-selection` zu füllen.
- web-quality.yml + Lighthouse/pa11y nur für Web-Profile sinnvoll — bei internal-tool entfernen.

---

## v2.1 — Template-Doku vom Projekt getrennt + Tooling
- **TEMPLATE-USAGE.md** (neu, Template-only): präzise Reihenfolge, alle Commands/Profile/Hooks/CI/Plugins.
- **README.md** (Template) schlank → zeigt auf USAGE + Init; **templates/README.project.md** = Projekt-README-Skelett.
- **scripts/init-project.sh**: tauscht README → Projekt-README, ersetzt [Projektname], legt context/+.env.local an,
  entfernt ALLE Template-Meta-Dateien und sich selbst. → Im neuen Projekt taucht keine Template-Beschreibung mehr auf.
- Tooling-Configs: **.gitleaks.toml**, **knip.json**, **.size-limit.json** (+ size-limit-Job in web-quality.yml).

---

## v3.0 — Plugin-First (Marketplace ist Single Source of Truth)
- Lokale `.claude/skills|agents|commands|scripts|rules` ENTFERNT — leben jetzt ausschließlich
  im **estores-Marketplace** (Plugins: estores-core / estores-compliance / estores-web).
- `.claude/settings.json`: `extraKnownMarketplaces` (estores) + `enabledPlugins` (estores-core).
  → Beim „Ordner vertrauen" installiert Claude Code Marketplace + Core-Plugin automatisch.
- `.claude/PLUGINS.md`: manueller Fallback (`/plugin marketplace add` + `/plugin install`),
  da der Auto-Prompt je CC-Version/Headless-Modus nicht immer greift.
- `/project-type` (im Plugin) trägt Profil-Plugins (web/compliance) selbst in enabledPlugins ein.
- Rules sind jetzt Skills im estores-core-Plugin. Hooks kommen via plugin-eigenes hooks.json.
- Keine Duplikate mehr zwischen Template und Marketplace.
