# Ukenotater og dagnotater i Obsidian

Et enkelt oppsett for dagnotater og ukenotater:

- **Ukenotatet** viser alle dagnotatene i uka, mandag til søndag, og en tabell over notatene du har jobbet med den uka.
- **Dagnotatet** lenker til uka, til i går og til i morgen.
- Klikker du på en dag som ikke finnes ennå i ukenotatet, lages dagnotatet med riktig mal og havner i riktig mappe.

- **Startsiden** åpner ukenotatet for denne uka hver gang du starter Obsidian, så du havner rett i uka som er nå.

Oppsettet bruker tre plugins, [Periodic Notes](https://github.com/liamcain/obsidian-periodic-notes), [Templater](https://github.com/SilentVoid13/Templater) og [Homepage](https://github.com/mirnovov/obsidian-homepage). Alle tre ligger allerede i dette vaultet.

## Kom i gang

### 1. Åpne i Obsidian
1. Pakk ut ZIP-filen og flytt mappen til et fast sted. Første gang du bruker Obsidian: velg **Open folder as vault** og pek på mappen. Har du allerede et vault: trykk på navnet til vaultet nede til venstre, velg **Manage vaults…** og så **Open folder as vault**.
2. Trykk **Trust author and enable plugins** når Obsidian spør.

### 2. To innstillinger du må sette selv
Disse lagres på maskinen din og ikke i vaultet, så de kan ikke sendes med:

1. **Språk:** se [Språk og ukestart](#språk-og-ukestart) under. Bruker du norsk, trenger du ikke gjøre noe.
2. **Templater:** gå til *Settings → Templater* og slå på **Trigger Templater on new file creation**. Templater spør om du stoler på vaultet. Svar ja.

### 3. Prøv det
Trykk **Cmd + P** (Mac) eller **Ctrl + P** (Windows) og kjør **Periodic Notes: Open weekly note**. Ukenotatet for denne uka lages i `logg/uker/`. Klikk på dagen i dag for å lage dagnotatet.

## Språk og ukestart

Oppsettet forutsetter at uka starter på **mandag**. Det styres av språket i Obsidian (*Settings → General → Language*):

- **Norsk:** du trenger ikke gjøre noe.
- **Engelsk:** velg **English (GB)**, ikke *English*. Vanlig *English* følger amerikansk standard, der uka starter på søndag, og da havner du i feil ukenotat. Med *English (GB)* er grensesnittet fortsatt engelsk, men uka starter på mandag.

Start Obsidian på nytt etter at du har byttet språk.

> Vil du beholde vanlig *English*? Da kan du installere pluginen [Calendar](https://github.com/liamcain/obsidian-calendar-plugin) og sette *Start week on* til **Monday**.

## Hvordan det henger sammen

```
templates/
  uke.md           ← ukemal (Periodic Notes fyller den ut)
  dag.md           ← dagmal (Templater fyller den ut)
logg/
  2026-10-08.md    ← dagnotater
  uker/
    2026-uke-41.md ← ukenotater
```

| Hva | Hvem lager filen | Hvem fyller inn innholdet |
|---|---|---|
| Ukenotat | Periodic Notes | Periodic Notes, med `uke.md` |
| Dagnotat via *Open daily note* | Periodic Notes (tom fil) | Templater, med `dag.md` |
| Dagnotat via klikk i ukenotatet | Obsidian (tom fil) | Templater, med `dag.md` |

- **Ukemalen** bruker bare plassholdere som Periodic Notes forstår selv, som `{{monday:YYYY-MM-DD}}`. Den trenger ikke Templater.
- **Dagmalen** bruker Templater, fordi Periodic Notes ikke er med når du klikker på en lenke. Templater leser datoen fra filnavnet, så notatet blir riktig også for andre dager enn i dag.
- **Dagnotatet havner alltid i riktig mappe.** Klikker du på en lenke, legger Obsidian filen der du har valgt at nye notater skal havne. Dagmalen flytter den til mappen for dagnotater som er valgt i Periodic Notes. Vil du bruke en annen mappe, endrer du den bare i Periodic Notes.

## Bruke oppsettet i et vault du har fra før

1. Kopier mappen `templates/` (eller filene `uke.md` og `dag.md`) inn i vaultet ditt.
2. Installer **Periodic Notes**, **Templater** og **Homepage** under *Settings → Community plugins → Browse*.
3. Fyll inn innstillingene under. Ikke kopier `.obsidian`-mappen, for da overskriver du innstillingene du har fra før.
4. Les [Språk og ukestart](#språk-og-ukestart).

Har du allerede en malmappe i Templater, kan du legge `uke.md` og `dag.md` i den og bruke de stiene i stedet. Husk også å endre `"templates"` i base-blokken nederst i `uke.md`, slik at malene ikke dukker opp i tabellen.

### Innstillinger

**Periodic Notes**

| Innstilling | Verdi |
|---|---|
| Daily Notes → Format | `YYYY-MM-DD` |
| Daily Notes → Folder | `logg` (eller din egen mappe) |
| Daily Notes → Template | *tom*. Templater fyller inn dagnotatet |
| Weekly Notes → Format | `GGGG-[uke-]WW` |
| Weekly Notes → Folder | `logg/uker` (eller din egen mappe) |
| Weekly Notes → Template | `templates/uke` |

**Templater**

| Innstilling | Verdi |
|---|---|
| Template folder location | `templates` |
| Trigger Templater on new file creation | på |
| Mode | *File regex templates* |
| File regex template | `(^\|/)\d{4}-\d{2}-\d{2}\.md$` → `templates/dag.md` |

Regelen betyr at bare filer som heter nøyaktig en dato, for eksempel `2026-10-08.md`, får dagmalen. Andre nye notater påvirkes ikke.

**Homepage**

| Innstilling | Verdi |
|---|---|
| Homepage → Type | *Weekly Note* (bruker ukenotatet fra Periodic Notes) |
| Open on startup | på |
| Open when empty | på |
| Use when opening normally | av |
| Separate mobile homepage | av |
| Opening method | Replace all open notes |
| Manual opening method | Keep open notes |
| Pin | på |
| Hide release notes | på |
| Auto-create | av |

**Obsidian**

- Slå av kjerne-pluginen **Daily notes** (*Settings → Core plugins*), slik at det bare er Periodic Notes som styrer dagnotatene.

<details>
<summary><strong>Litt mer avansert: Bruker du allerede mappemaler i Templater?</strong></summary>

Templater kan bare bruke én modus om gangen, enten *Folder templates* eller *File regex templates*. Bruker du mappemaler fra før, beholder du dem. Da legger du til dagmalen som mappemaler i stedet for regex-regelen over.

Når du klikker på en dag i ukenotatet, lager Obsidian filen der nye notater havner (*Settings → Files and links → Default location for new notes*). Dagmalen må derfor også gjelde den mappen:

| Mappe | Mal | Når den brukes |
|---|---|---|
| `logg` | `templates/dag.md` | *Open daily note* |
| Mappen for nye notater, f.eks. `Innboks` (eller `/` hvis nye notater havner i roten) | `templates/innboks.md` (se under) | Klikk på en dag i ukenotatet |

Lag `templates/innboks.md`. Den sender notater som heter en dato, til dagmalen, som flytter dem til `logg/`. Andre nye notater lar den være i fred:

```
<%*
if (/^\d{4}-\d{2}-\d{2}$/.test(tp.file.title)) {
  tR += await tp.file.include("[[dag]]");
}
-%>
```

Har mappen for nye notater allerede en mappemal, legger du den inn som et «ellers», så den fortsatt brukes for vanlige notater:

```
<%*
if (/^\d{4}-\d{2}-\d{2}$/.test(tp.file.title)) {
  tR += await tp.file.include("[[dag]]");
} else {
  tR += await tp.file.include("[[din vanlige mal]]");
}
-%>
```

Undermapper uten egen mappemal arver malen fra mappen over. Har `logg/` undermapper der du lager andre notater, bør de få sin egen mappemal.

</details>

## Hvis noe ikke virker

- **«Open weekly note» åpner forrige uke, eller søndagen er feil:** uka starter på søndag. Se [Språk og ukestart](#språk-og-ukestart).
- **Et dagnotat blir lagd, men er tomt:** sjekk at *Trigger Templater on new file creation* er på, og at regex-regelen peker på `templates/dag.md`. Er filen allerede laget tom, sletter du den og lager den på nytt.
- **«… is not created yet. Click to create» i ukenotatet:** det er normalt for dager som ikke har et notat ennå. Klikk for å lage det.
- **Rare verdier som `{{monday:YYYY-MM-DD}}` eller `<% … %>`:** du ser på selve malen. Plassholderne fylles ut først når et notat lages fra malen.

## Plugins og lisenser

Vaultet inneholder uendrede kopier av disse pluginene, slik at oppsettet virker med en gang. Du kan oppdatere dem som vanlig under *Settings → Community plugins*.

| Plugin | Versjon | Lisens | Kildekode |
|---|---|---|---|
| Periodic Notes | 0.0.17 | MIT | [github.com/liamcain/obsidian-periodic-notes](https://github.com/liamcain/obsidian-periodic-notes) |
| Templater | 2.25.0 | AGPL-3.0 | [github.com/SilentVoid13/Templater](https://github.com/SilentVoid13/Templater) |
| Homepage | 4.5.0 | MIT | [github.com/mirnovov/obsidian-homepage](https://github.com/mirnovov/obsidian-homepage) |
