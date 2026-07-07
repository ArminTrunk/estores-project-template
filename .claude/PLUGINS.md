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
Profil-Plugins werden von `/project-type` automatisch in `enabledPlugins` eingetragen.
