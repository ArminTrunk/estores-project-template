# Compliance: [Projektname]

> Wird vom `/project-type` Command auf das gewählte **Profil** zugeschnitten.
> Nicht zutreffende Blöcke entfernen. Quelle der Regeln: Skills `privacy-dsgvo` + `accessibility`
> (estores-compliance-Plugin) und `security` (estores-core-Plugin).

**Profil:** [marketing-site / headless-cms-site / internal-tool / public-app-pii]
**Verarbeitet Personendaten:** [ja / teilweise / nein]
**Letztes Audit:** [DATUM]

---

## 1. Datenschutz / DSGVO  (Pflicht bei PII)

### Verzeichnis der Verarbeitungstätigkeiten (Art. 30)
| Datenart | Zweck | Rechtsgrundlage (Art. 6) | Speicherdauer | Wer hat Zugriff |
|---|---|---|---|---|
| | | | | |

### Auftragsverarbeiter (Art. 28) — AVV-Status
| Dienst | Zweck | Hosting-Region | AVV vorhanden | Drittland-Grundlage |
|---|---|---|---|---|
| | | | ☐ | |

### Checkliste
- [ ] Rechtsgrundlage je Datenart festgelegt
- [ ] Datenminimierung geprüft (keine unnötigen Felder)
- [ ] Keine PII in Logs / URLs / Analytics-Events
- [ ] Consent vor nicht-essenziellem Tracking (Opt-in, widerrufbar, Nachweis)
- [ ] Cookie-Banner / Consent-Management korrekt
- [ ] Auskunft (Daten-Export) technisch umsetzbar
- [ ] Löschung (Hard-Delete inkl. Abhängigkeiten + Backup-Konzept) umsetzbar
- [ ] Löschfristen + automatischer Löschjob je Datenart
- [ ] TOMs dokumentiert (Art. 32 → siehe Security)
- [ ] Datenpannen-Runbook (72h-Meldung, Art. 33) abgelegt
- [ ] Impressum vorhanden
- [ ] Datenschutzerklärung vorhanden + aktuell

## 2. Barrierefreiheit / BFSG  (Pflicht bei öffentlichen Web-Profilen)
- [ ] Semantik: Heading-Struktur, Landmarks, echte Buttons/Links
- [ ] Komplett per Tastatur bedienbar, Fokus sichtbar, keine Traps
- [ ] Alt-Texte; Kontrast ≥ 4.5:1; nicht nur über Farbe informieren
- [ ] Formular-Labels + Fehler programmatisch verknüpft
- [ ] axe/pa11y/Lighthouse-a11y in CI grün
- [ ] Manueller Tastatur- + Screenreader-Stichproben-Durchlauf

## 3. Security  (alle Profile — siehe Skill `security`, estores-core-Plugin)
- [ ] Input-Validierung an allen Eingängen
- [ ] Auth/RBAC auf allen geschützten Routen
- [ ] Security-Header + CORS korrekt
- [ ] Secrets nur in Env, Rotation geplant
- [ ] Dependency-Audit grün (CI)
- [ ] Secret-Scan grün (CI)

## 4. SEO / Performance  (Web-Profile — siehe Skill `seo-performance`, estores-web-Plugin)
- [ ] Meta/OG/Canonical je Seite, robots.txt + sitemap.xml
- [ ] Core Web Vitals in Budget (LCP/INP/CLS)
- [ ] Strukturierte Daten (JSON-LD) valide
