---
week_start: "{{monday:YYYY-MM-DD}}"
week_end: "{{sunday:YYYY-MM-DD}}"
week_end_limit: "{{date+7d:YYYY-MM-DD}}"
tags:
  - weekly
---

# Notes from week {{date:W}}

## Monday

![[{{monday:YYYY-MM-DD}}]]

---

## Tuesday

![[{{tuesday:YYYY-MM-DD}}]]

---

## Wednesday

![[{{wednesday:YYYY-MM-DD}}]]

---

## Thursday

![[{{thursday:YYYY-MM-DD}}]]

---

## Friday

![[{{friday:YYYY-MM-DD}}]]

---

## Saturday

![[{{saturday:YYYY-MM-DD}}]]

---

## Sunday

![[{{sunday:YYYY-MM-DD}}]]

---

## Notes I worked on this week

```base
formulas:
  day: 'file.mtime.format("dddd D MMMM")'
filters:
  and:
    - file.mtime >= this.week_start
    - file.mtime < this.week_end_limit
    - file.folder != "Templates"
    - file.path != this.file.path
views:
  - type: table
    name: Edited
    groupBy:
      property: formula.day
      direction: ASC
    order:
      - file.name
      - file.mtime
```
