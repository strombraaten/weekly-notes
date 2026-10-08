<%*
const d = moment(tp.file.title, "YYYY-MM-DD");
// Move the note to the daily notes folder (from Periodic Notes), wherever Obsidian created it
const folder = app.plugins.getPlugin("periodic-notes")?.settings?.daily?.folder?.trim() ?? "";
const here = tp.file.folder(true).replace(/^\/$/, "");
if (here !== folder) await tp.file.move((folder ? folder + "/" : "") + tp.file.title);
-%>
---
date: "<% d.format("YYYY-MM-DD") %>"
week: "[[<% d.format("GGGG-[week-]WW") %>]]"
previous: "[[<% d.clone().subtract(1, "day").format("YYYY-MM-DD") %>]]"
next: "[[<% d.clone().add(1, "day").format("YYYY-MM-DD") %>]]"
related:
tags:
  - daily
---

## Today's notes

