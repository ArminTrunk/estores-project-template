# Threat Model: [Projektname]

> Pflicht für Profil **public-app-pii**, empfohlen für **internal-tool**.
> Lebendiges Dokument — bei Architektur-Änderungen aktualisieren.
> Methode-Quelle: Skills `systems-analyzer` + `security` (estores-core-Plugin).

## 1. Datenklassifizierung
| Daten | Klasse (öffentlich/intern/PII/sensibel) | Speicherort | Verschlüsselung (at rest/in transit) |
|---|---|---|---|
| | | | |

## 2. Trust Boundaries & Datenfluss
```
[Nutzer/Browser]  --(HTTPS)-->  [Frontend]  --(API)-->  [Backend]  -->  [DB]
                                     |                       |
                                 [CMS/CDN]              [3rd-Party: Mail/Analytics/KI]
```
Markiere jede Grenze, an der Daten zwischen Vertrauenszonen wechseln.

## 3. Bedrohungen (STRIDE-lite)
| Kategorie | Bedrohung | Betroffene Komponente | Gegenmaßnahme | Status |
|---|---|---|---|---|
| Spoofing | schwache Auth | | MFA / starke Sessions | |
| Tampering | Manipulation von Requests | | Validierung / Signaturen | |
| Repudiation | fehlende Nachvollziehbarkeit | | Audit-Log | |
| Info Disclosure | PII-Leak (Logs/Errors) | | PII-Scrubbing | |
| DoS | Überlast öffentlicher Endpoints | | Rate-Limiting / Caching | |
| Elevation | fehlende Autorisierung | | RBAC je Route | |

## 4. Öffentliche Endpoints (erhöhtes Risiko)
- [ ] Rate-Limiting / Bot-Schutz
- [ ] Strikte Input-Validierung + Größenlimits
- [ ] Keine internen Fehlerdetails nach außen
- [ ] Idempotenz wo nötig (Zahlungen/Formulare)

## 5. Top-Risiken & Maßnahmen
| Risiko | Wahrscheinlichkeit | Impact | Maßnahme | Verantwortlich |
|---|---|---|---|---|
| | | | | |
