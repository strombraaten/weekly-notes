---
uke_start: "{{monday:YYYY-MM-DD}}"
uke_slutt: "{{sunday:YYYY-MM-DD}}"
uke_slutt_grense: "{{date+7d:YYYY-MM-DD}}"
tags:
  - ukentlig
---

# Notater fra uke {{date:W}}

## Mandag

![[{{monday:YYYY-MM-DD}}]]

---

## Tirsdag

![[{{tuesday:YYYY-MM-DD}}]]

---

## Onsdag

![[{{wednesday:YYYY-MM-DD}}]]

---

## Torsdag

![[{{thursday:YYYY-MM-DD}}]]

---

## Fredag

![[{{friday:YYYY-MM-DD}}]]

---

## Lørdag

![[{{saturday:YYYY-MM-DD}}]]

---

## Søndag

![[{{sunday:YYYY-MM-DD}}]]

---

## Notater jeg jobba med denne uka

```base
formulas:
  dag: 'file.mtime.format("dddd D. MMMM")'
filters:
  and:
    - file.mtime >= this.uke_start
    - file.mtime < this.uke_slutt_grense
    - file.folder != "templates"
    - file.path != this.file.path
views:
  - type: table
    name: Endret
    groupBy:
      property: formula.dag
      direction: ASC
    order:
      - file.name
      - file.mtime
```
