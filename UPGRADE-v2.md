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

---

## v3.1 — Review Juli 2026 (Stand der Technik + Bugfixes)

**Kritische Fixes:**
- `lefthook.yml`: `npx gitleaks` war KAPUTT (kein verlässliches npm-Paket; `protect`
  seit v8.19 deprecated) → jetzt `gitleaks git --pre-commit --staged` mit Binary-Check
  + klarer Installationsanleitung (`brew install gitleaks`).
- `.mcp.json.example`: `@modelcontextprotocol/server-github` ist archiviert →
  offizieller GitHub-MCP-Server (Remote, `api.githubcopilot.com/mcp/`).
- `.env.example`: an .mcp.json angeglichen (GITHUB_PAT, SUPABASE, DATAFORSEO);
  Brave entfernt (Server archiviert, war nirgends referenziert).
- `.claude/settings.json`: Deny-Liste um die realen `.env`-Varianten ergänzt (`.env.local`,
  `.env.*.local`, `.env.development/production/staging/test` — Root + verschachtelt;
  `.env.example` bleibt bewusst lesbar; neue `.env.<mode>`-Namen laut AGENTS.md nachtragen);
  Fallback-Modelle aktualisiert
  (`claude-sonnet-5`, `claude-haiku-4-5`); `~/.config/gh` zusätzlich geschützt.
- `.editorconfig`: `[*.{py}]` → `[*.py]`.

**CI nach Stand der Technik gehärtet:**
- Alle Workflows: Top-Level `permissions: contents: read` (Least Privilege) +
  `concurrency` (überholte PR-Läufe abbrechen).
- Drittanbieter-Actions auf Commit-SHA gepinnt (Supply-Chain; Konsens seit dem
  tj-actions-Angriff 2025). Dependabot pflegt die Pins weiter.
- `gitleaks-action` v2→v3; Hinweis auf kostenlosen `GITLEAKS_LICENSE` für Org-Repos.
- NEU `dependency-review` (security-scan): blockiert PRs, die verwundbare
  Dependencies NEU einführen (`fail-on-severity: high`).
- NEU `workflow-lint` (actionlint): prüft die Workflows selbst — genau die
  Fehlerklasse aus SKILL-OBSERVATIONS Beobachtung 1.
- NEU `pr-title` (ci.yml): Conventional-Check des PR-Titels (wichtig bei Squash-Merge).
- Node 22→24 (aktuelle LTS); Version jetzt EINMAL in `.nvmrc`, CI liest
  `node-version-file` (kein Drift mehr zwischen Workflows).
- Dependabot: `cooldown` (7/14 Tage) als Supply-Chain-Schutz; Actions-Updates gruppiert.
- `claude-review.yml`: `track_progress`, Draft-PRs übersprungen, Trigger um
  `ready_for_review`/`reopened` ergänzt.
- web-quality: `sleep 5` → `wait-on` (kein Flaky-Start mehr).

**Neu hinzugekommen:**
- `.nvmrc` · `.vscode/extensions.json` · `.devcontainer/` (Node 24 + gitleaks +
  gh + Claude Code vorinstalliert — auch für Codespaces)
- `.github/rulesets/branch-protection.json` — Branch-Schutz als Code;
  `init-project.sh` importiert ihn optional per `gh`.
- Issue-Templates als **Issue Forms** (YAML, strukturierte Pflichtfelder) statt Markdown.
- `init-project.sh`: sed-Escaping für Sonderzeichen im Projektnamen (& / \).

**Bewusst NICHT gemacht:**
- Renovate statt Dependabot (Dependabot + groups + cooldown reicht für Teamgröße)
- OSSF Scorecard / harden-runner (Mehrwert primär für öffentliche OSS-Repos)
- Merge Queue (erst ab deutlich mehr parallelen PRs sinnvoll)
- commitlint zusätzlich zu lefthook-Regex + PR-Titel-Check (Redundanz)
- LICENSE-Datei (Template ist öffentlich sichtbar, aber proprietär — "all rights
  reserved" ist ohne LICENSE der Default; bei Bedarf bewusst entscheiden)
