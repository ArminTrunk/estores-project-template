# Plugins dieses Projekts

Skills, Agents, Commands und Hooks kommen aus dem **estores-Marketplace** —
nicht lokal in diesem Repo. Registriert in `.claude/settings.json`
(`extraKnownMarketplaces` + `enabledPlugins`).

## Normalfall
Beim ersten Öffnen in Claude Code und „Ordner vertrauen" fragt Claude Code, ob der
estores-Marketplace + `estores-core` installiert werden sollen → bestätigen, dann `/reload-plugins`.

## Fallback (falls kein Auto-Prompt — in manchen CC-Versionen / im -p Modus)
```
/plugin marketplace add ArminTrunk/estores-marketplace
/plugin install estores-core@estores
# je nach Profil zusätzlich:
/plugin install estores-web@estores
/plugin install estores-compliance@estores
/reload-plugins
```

## Offizielle Anthropic-Plugins (Standard, einmal pro Projekt)
```
/plugin install commit-commands@claude-plugins-official
/plugin install pr-review-toolkit@claude-plugins-official
```

## Design-Intelligenz für Web-Profile (empfohlen, Opt-in)
[ui-ux-pro-max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) — Design-System-Generator
(67 UI-Stile, branchenspezifische Paletten/Fonts, Anti-Patterns, Pre-Delivery-Checkliste).
MIT-Lizenz, benötigt Python 3. Aktiviert sich automatisch bei UI/UX-Aufgaben.
```
/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill
/plugin install ui-ux-pro-max@ui-ux-pro-max-skill
```
> Drittanbieter-Code (führt lokal Python-Scripts aus): vor Team-Rollout einmal
> `scripts/search.py` sichten und auf ein Release pinnen statt `main` zu folgen.
> Nur EIN Design-Skill installieren — mehrere überlappende verschlechtern das Triggering.
Profil-Plugins werden von `/project-type` automatisch in `enabledPlugins` eingetragen.
