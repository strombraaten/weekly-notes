# Ukenotater og dagnotater i Obsidian

Få oversikt over uka du er i med ukesvisningen. Ta en dag om gangen med de daglige notatene. Og gjør det lett tilgjengelig med at du alltid kommer tilbake til uka som en startside.

## Kom i gang

### 1. Åpne i Obsidian
1. Pakk ut ZIP-fila, og flytt mappa dit du vil ha den. Første gang du bruker Obsidian: velg **Open folder as vault** og åpne mappa. Hvis du har et vault åpent fra før kan du åpne opp Command bar med cmd+p, og søke opp **Manage vaults…**, for så å velge **Open folder as vault**.
2. Velg English (GB) ellers norsk som språk, hvis du vil at uka skal starte på en mandag. Dette kan du alltids endre senere. se [Språk og ukestart](#språk-og-ukestart) hvis du vil forstå det bedre.
2. Trykk **Trust author and enable plugins** når Obsidian spør.

### 2. Én innstilling du må sette selv

Gå til *Settings → Templater* og slå på **Trigger Templater on new file creation**. Templater spør om du stoler på vaultet. Svar ja.

### 3. For en sømløs start er det best å starte Obsidian på nytt
Avslutt Obsidian helt (**Cmd + Q** på Mac) og åpne vaultet igjen. Da åpnes ukesvisningen din som en startside fra nå av.
Men det krever en omstart for at det skal fungere.

Du kommer alltid tilbake til ukesvisningen med **Alt + W** (Option + W på Mac).

### 4. Voila! Oversikten er klar

For å starte et daglig notat trykker du på `"year-month-date" is not created yet. Click to create.`

## Språk og ukestart

Oppsettet forutsetter at uka starter på **mandag**. Det styres av språket i Obsidian (*Settings → General → Language*):

- **Velg norsk** dersom du vil ha all tekst i grensesnittet på norsk.
- **Velg "English (GB)"**, ikke *English*, dersom du vil ha grensesnittet på engelsk. Vanlig *English* følger amerikansk standard, der uka starter på søndag, og da havner du i feil ukenotat. Med *English (GB)* er grensesnittet fortsatt engelsk, men uka starter på mandag.

> Hvis du på død og liv vil beholde vanlig *English* kan du installere [Calendar](https://github.com/liamcain/obsidian-calendar-plugin)-pluginen og sette *Start week on* til **Monday**.

## Vil du bruke oppsettet i et vault du har fra før?

1. Kopier mappen `templates/` (eller kun disse to filene — `uke.md` og `dag.md`) inn i vaultet ditt.
2. Installer **Periodic Notes**, **Templater** og **Homepage** under *Settings → Community plugins → Browse*.
3. Fyll inn innstillingene under.
4. Les [Språk og ukestart](#språk-og-ukestart).

Hvis du bruker Templater fra før kan du legge `uke.md` og `dag.md` der du har dine andre maler. Da må du riktignok endre på stien (altså hvor fila ligger) nederst i `uke.md` (i base-blokken).

### Anbefalte innstillinger

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

<details>
<summary><strong>Litt mer avansert: Bruker du allerede maler for ulike mapper i Templater?</strong></summary>

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

## FAQ

- **Startsiden åpner seg ikke:** Trykk **Alt + W** for å gå rett til startsida. Eventuelt kan du åpne opp command bar med **Cmd + P** og begynn å skrive "homepage", så kan du åpne den derfra.
- **«Open weekly note» åpner forrige uke, eller uka starter på søndag:** Se [Språk og ukestart](#språk-og-ukestart).
- **Et dagsnotat blir lagd, men er tomt:** sjekk at *Trigger Templater on new file creation* er på, og at regex-regelen peker på `templates/dag.md`. Er filen allerede laget tom, sletter du den og lager den på nytt.
- **Hva er de rare verdiene som `{{monday:YYYY-MM-DD}}` eller `<% … %>`:** det er selve malen du ser på. De fylles ut dynamisk når du oppretter en ny fil.

## Plugins og lisenser

Vaultet baserer seg på tre plugins for å få dette til å funke, og inneholder uendrede kopier av disse pluginene, slik at det bare skal virke automagisk. 

I ny og ne må de sikkert oppdateres, og det gjør du under *Settings → Community plugins*.

| Plugin | Versjon | Lisens | Kildekode |
|---|---|---|---|
| Periodic Notes | 0.0.17 | MIT | [github.com/liamcain/obsidian-periodic-notes](https://github.com/liamcain/obsidian-periodic-notes) |
| Templater | 2.25.0 | AGPL-3.0 | [github.com/SilentVoid13/Templater](https://github.com/SilentVoid13/Templater) |
| Homepage | 4.5.0 | MIT | [github.com/mirnovov/obsidian-homepage](https://github.com/mirnovov/obsidian-homepage) |
