# Anleitung: Dieses Template verwenden

> ⚠️ **Nur-Template-Datei.** `scripts/init-project.sh` entfernt sie beim Projektstart,
> damit im echten Projekt keine Template-Mechanik mehr auftaucht.

Dieses Repo ist ein Claude-Code-Startpunkt für **alle EStores-Projekttypen** —
Websites (mit/ohne Headless-CMS), interne Tools und öffentliche Tools mit Personendaten.
Welche Bausteine pro Projekt gelten, steuert das **Profil** (`/project-type`).

---

## 1. Reihenfolge — so startest du ein neues Projekt (genau diese Schritte)

| # | Schritt | Befehl | Ergebnis |
|---|---------|--------|----------|
| 1 | Repo aus Template erzeugen | GitHub „Use this template" → klonen | Eigenes Projekt-Repo |
| 2 | **Projekt initialisieren** | `./scripts/init-project.sh "Projektname"` | README→Projekt-README, Template-Meta entfernt, `context/` + `.env.local` angelegt |
| 3 | Git-Hooks aktivieren | `npm i -D lefthook && npx lefthook install` | Secrets-/Lint-/Commit-Hooks lokal |
| 4 | Claude Code öffnen + Ordner vertrauen | `claude` | Auto-Prompt installiert estores-Marketplace + `estores-core` (Fallback: `.claude/PLUGINS.md`) |
| 5 | Claude Code initialisieren | `claude /init` | Claude liest CLAUDE.md + Plugins |
| 6 | **Profil festlegen** | `/project-type` | Pflicht-Skills + Compliance-Checklisten gesetzt |
| 7 | Stack wählen | `/stack-selection` | `stack.md` + ARCHITECTURE-Entwurf befüllt |
| 8 | Phase-0-Überblick | `/plan` | Projektstand + nächster Schritt |
| 9 | Discovery befüllen | (Prompt in `docs/DISCOVERY.md`) | Problem, Zielgruppe, MVP |
| 10 | Architektur + Roadmap | (Prompts in den Docs) | ARCHITECTURE.md, ROADMAP.md |
| 11 | Feature entwickeln | `/create-feature` | Branch, Code, Tests, Changelog, Commit |
| 12 | Vor Commit prüfen | `/local-review` (+ §4-Gates) | grün/gelb/rot |
| 13 | PR-Review | `/review-pr` | PASS/FAIL je Kategorie |
| 14 | Auf Staging | `/deploy-staging` | Deploy + Smoke-Test |
| 15 | Release | `/release` | Version, Tag, main, Changelog |

**Faustregel Reihenfolge:** erst *Profil* (Schritt 6), dann *Stack* (7) — das Profil
entscheidet, welche Skills und Checks überhaupt gelten.

---

## 2. Slash-Commands (Werkzeuge)

| Command | Was | Wann |
|---------|-----|------|
| `/project-type` | Profil + Pflicht-Skills + Compliance-Checklisten setzen | einmalig zu Beginn |
| `/stack-selection` | geführte Stack-Wahl, befüllt ARCHITECTURE | nach Profil |
| `/plan` | Projektstand + Empfehlung für die Session | Session-Start |
| `/create-feature` | Feature-Branch → Code → Tests → Commit | je Feature |
| `/local-review` | Pre-Commit-Review uncommitteter Änderungen | vor jedem Commit |
| `/review-pr` | vollständiges Review des PR-Diffs | vor Merge |
| `/security-check` | Security-Audit (security-auditor) | bei sicherheitsrelevanten Änderungen / vor Release |
| `/privacy-check` | DSGVO-Audit (compliance-auditor) | bei Personendaten |
| `/a11y-check` | Barrierefreiheit WCAG/BFSG | bei öffentlichen Web-Seiten |
| `/deploy-staging` | Deploy auf Staging + Smoke-Test | nach grünem Review |
| `/release` | Release-Prozess auf Production | wenn Staging stabil |

## 3. Skills, Agents, Automatik

> Skills, Agents, Commands, Rules und Hooks kommen aus den **estores-Plugins** (Marketplace),
> nicht lokal im Repo. Siehe `.claude/PLUGINS.md`.

**Skills** (aus Plugins, laden je nach Kontext): `security`, `testing`, `database`,
`deployment`, `observability`, `privacy-dsgvo`, `accessibility`, `seo-performance`,
`headless-cms`, `project-wiki`, `decision-architect`, `systems-analyzer`,
`critical-evaluator`, `stack`.

**Agents** (per Task/Command aufgerufen): `code-reviewer`, `security-auditor`,
`compliance-auditor`, `db-expert`, `test-engineer`.

**Hooks (aus `estores-core`-Plugin, laufen automatisch in Claude Code):**
- PreToolUse/Bash → blockiert gefährliche Befehle
- PreToolUse/Write|Edit → blockiert Secret-Leaks
- PostToolUse/Write|Edit → Auto-Lint

**Echte Git-Hooks (`lefthook.yml`, laufen auch ohne Claude Code):**
gitleaks (Secrets), Lint, Typecheck, Conventional-Commit-Zwang, Tests beim Push.

**CI/CD (`.github/workflows/`):**
- `ci.yml` → Typecheck, Lint, Tests, E2E, Deploy-Hooks
- `security-scan.yml` → Dependency-Audit, TruffleHog, CodeQL (+ wöchentlich)
- `web-quality.yml` → Lighthouse-Budgets (CWV/SEO/a11y) + pa11y (nur Web-Profile)

## 4. Qualitäts-Gates — wann welcher Check (richtige Reihenfolge)

```
Coden ──▶ /local-review ──▶ [profilabhängig] ──▶ Commit ──▶ PR /review-pr ──▶ Merge
                              ├─ PII?     → /privacy-check
                              ├─ Web?     → /a11y-check
                              └─ Security?→ /security-check
                                                   │
                              Staging /deploy-staging ──▶ /release (+ /security-check)
```
Definition of Done: `templates/definition-of-done.md` (profilabhängig).

## 5. Profile → welche Skills/Plugins (Pflicht-Matrix)

| Skill / Doc | marketing | cms | internal | public-pii |
|-------------|:--:|:--:|:--:|:--:|
| security, testing | ✓ | ✓ | ✓ | ✓ |
| accessibility, seo-performance | ✓ | ✓ | – | ✓ |
| headless-cms | – | ✓ | – | – |
| privacy-dsgvo, observability | – | (Cookies) | ✓ | ✓ |
| docs/THREAT-MODEL | – | – | empfohlen | ✓ |

**Marketplace-Plugins (Standard, nicht optional):** `estores-core` (immer) ·
`estores-compliance` (PII-Profile) · `estores-web` (Web-Profile). `/project-type` trägt die
Profil-Plugins automatisch in `.claude/settings.json → enabledPlugins` ein.
Projektindividuelles (`docs/`, CI, `lefthook.yml`, Tooling-Configs) bleibt im Repo;
die wiederverwendbare Claude-Intelligenz kommt zentral aus dem Marketplace.

## 5b. Code-Qualität-Tooling (Configs liegen bei, an Stack anpassen)
- `.gitleaks.toml` — Secret-Scan-Regeln (von lefthook + CI genutzt)
- `knip.json` — findet toten Code, ungenutzte Exports und Dependencies (`npx knip`)
- `.size-limit.json` — Bundle-Budgets, gekoppelt an Core Web Vitals (`npx size-limit`, auch in CI)

## 6. Empfohlene Fremd-Plugins / MCP (nach Bedarf, kosten Kontext)
- `commit-commands@claude-plugins-official`, `pr-review-toolkit@claude-plugins-official`
- LSP TypeScript / pyright · Partner-MCP: Supabase, Vercel, Sentry
- Playwright-MCP (E2E), Chrome-DevTools-MCP (CWV), Context7 (aktuelle Lib-Doku)

---

## 7. Was beim `init-project` entfernt wird (Template-only)
`TEMPLATE-USAGE.md` · `UPGRADE-v2.md` · `templates/README.project.md` ·
`scripts/init-project.sh` (sich selbst).
Alles andere bleibt und wird zum Projekt.
