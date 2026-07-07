# Session-Start Prompt (VERALTET)

> Seit estores-core 2.1 injiziert ein **SessionStart-Hook** Backlog,
> Prioritäten und letzte Entscheidungen automatisch in jede Session —
> dieser manuelle Prompt ist nur noch Fallback für Umgebungen ohne Plugins.


Kopiere diesen Prompt zu Beginn jeder neuen Claude Code Session:

---

```
Lies folgende Dateien in dieser Reihenfolge und gib mir danach
eine kurze Zusammenfassung auf Deutsch:

1. CLAUDE.md
2. context/current-priorities.md
3. docs/ROADMAP.md (nur den nächsten Milestone)
4. decisions/log.md (letzte 5 Einträge)

Sage mir danach:
- Was ist der aktuelle Projektstand? (3 Sätze)
- Was sind die 3 wichtigsten offenen Punkte?
- Was empfiehlst du für diese Session?
- Gibt es Widersprüche oder Unklarheiten in den Dokumenten?

Erkläre alles in einfacher Sprache, keine Fachbegriffe ohne Erklärung.
```

---

**Tipp:** Speichere diesen Prompt als Snippet in Cursor / VSCode
für schnellen Zugriff am Session-Start.
