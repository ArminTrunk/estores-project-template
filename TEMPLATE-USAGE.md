# Anleitung: Dieses Template verwenden

> ⚠️ **Nur-Template-Datei.** `scripts/init-project.sh` entfernt sie beim Projektstart,
> damit im echten Projekt keine Template-Mechanik mehr auftaucht.

Dieses Repo ist ein Claude-Code-Startpunkt für **alle EStores-Projekttypen** —
Websites (mit/ohne Headless-CMS), interne Tools und öffentliche Tools mit Personendaten.
Welche Bausteine pro Projekt gelten, steuert das **Profil** (`/project-type`).

---

## 0. Schnellstart (zum Merken)

```
Use this template (GitHub)  →  Repo holen
→  brew install gitleaks gh  (+ einmalig: gh auth login)
→  ./scripts/init-project.sh "Name"
→  npm i -D lefthook && npx lefthook install
→  claude  →  /project-type  →  /stack-selection  →  /plan
```

> `gh` (GitHub CLI) wird von `/deploy-staging`, `/release` und dem Ruleset-Import
> im init-Skript benutzt — einmal installieren und mit `gh auth login` anmelden.

> Alternativ ohne lokale Installation: **GitHub Codespaces / Dev Container** öffnen —
> `.devcontainer/` bringt Node 24, gitleaks, gh und Claude Code fertig mit.

**Repo holen — zwei Wege, gleiches Ergebnis:**
- **Terminal:** `git clone https://github.com/ArminTrunk/<dein-repo>.git` und dann `cd <dein-repo>`
- **Cursor (per Maus):** `Cmd+Shift+P` → `Git: Clone` → Repo-URL einfügen → Zielordner wählen → „Open".
  Danach in Cursor das Terminal öffnen (*Terminal → New Terminal*) und ab `init-project.sh` weitermachen.

> `/`-Befehle (z. B. `/project-type`) immer **in Claude** (nach `claude`), nicht im normalen Terminal.

---

## 1. Reihenfolge — so startest du ein neues Projekt (genau diese Schritte)

| # | Schritt | Befehl | Ergebnis |
|---|---------|--------|----------|
| 1 | Repo aus Template erzeugen | GitHub „Use this template" → „Create a new repository" | Eigenes Projekt-Repo |
| 1b | Repo auf den Rechner holen | Terminal `git clone …` **oder** Cursor `Cmd+Shift+P` → `Git: Clone` | Projekt lokal offen |
| 1c | Werkzeuge installieren | `brew install gitleaks gh` + einmalig `gh auth login` | gitleaks (Secret-Scan) und gh (Ruleset-Import in Schritt 2, `/deploy-staging`, `/release`) |
| 2 | **Projekt initialisieren** | `./scripts/init-project.sh "Projektname"` | README→Projekt-README, Template-Meta entfernt, `context/` + `.env.local` angelegt, Branch-Schutz-Import (braucht gh aus 1c) |
| 3 | Git-Hooks aktivieren | `npm i -D lefthook && npx lefthook install` | Secrets-/Lint-/Commit-Hooks lokal (nutzen gitleaks aus 1c — Binary, KEIN npm-Paket) |
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
| `/hilfe` | Wegweiser: welche Situation → welches Werkzeug (für Nicht-Entwickler) | immer wenn unsicher |
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
| `/team-feature` | Agenten-Team für große Features (3–7× Kosten, opt-in) | nur bei großen Brocken |

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
- PreToolUse/Bash → blockiert gefährliche Befehle (inkl. `git push` auf main/staging)
- PreToolUse/Write|Edit|Read → blockiert Secret-Leaks und jeden Zugriff auf `.env*`
- PostToolUse/Write|Edit → Auto-Lint der geänderten Datei
- Zweite Verteidigungslinie: `.claude/settings.json` → `permissions.deny` (.env, SSH, AWS)

**Echte Git-Hooks (`lefthook.yml`, laufen auch ohne Claude Code):**
gitleaks (Secrets), Lint, Typecheck, Conventional-Commit-Zwang, Tests beim Push.

**CI/CD (`.github/workflows/`):**
- `ci.yml` → PR-Titel-Check (Conventional), Typecheck, Lint, Tests, E2E, Deploy-Hooks
- `security-scan.yml` → Dependency-Audit, Dependency-Review (neue Deps im PR),
  gitleaks, actionlint (Workflow-Lint), CodeQL (+ wöchentlich).
  ⚠️ Bei ORG-Repos: kostenloses Secret `GITLEAKS_LICENSE` setzen (gitleaks.io).
- `claude-review.yml` → automatisches Claude-Review jedes PRs (Secret ANTHROPIC_API_KEY nötig)
- `web-quality.yml` → Lighthouse-Budgets (CWV/SEO/a11y) + pa11y (nur Web-Profile)

**Branch-Schutz (settings-as-code):** `.github/rulesets/branch-protection.json` —
wird von `init-project.sh` per `gh` importiert (oder manuell: GitHub → Settings →
Rules → Rulesets → Import). Schützt `main` + `staging`: nur via PR, CI muss grün sein.

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
- `.nvmrc` — EINZIGE Quelle der Node-Version (24 = aktuelle LTS); CI liest sie via `node-version-file`
- `.vscode/extensions.json` — empfohlene Editor-Extensions (VS Code/Cursor schlägt sie vor)
- `.devcontainer/` — reproduzierbare Umgebung für Codespaces/Dev Containers
- `docs/BACKLOG.md` — einzige Task-Quelle (von `/plan` gelesen, von `/create-feature` gepflegt)

## 6. Empfohlene Fremd-Plugins / MCP (nach Bedarf, kosten Kontext)
- `commit-commands@claude-plugins-official`, `pr-review-toolkit@claude-plugins-official`
- LSP TypeScript / pyright · Partner-MCP: Supabase, Vercel, Sentry
- Playwright-MCP (E2E), Chrome-DevTools-MCP (CWV), Context7 (aktuelle Lib-Doku)

---

## 7. Was beim `init-project` entfernt wird (Template-only)
`TEMPLATE-USAGE.md` · `UPGRADE-v2.md` · `templates/README.project.md` ·
`scripts/init-project.sh` (sich selbst).
Alles andere bleibt und wird zum Projekt.
