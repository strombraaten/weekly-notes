<%*
const d = moment(tp.file.title, "YYYY-MM-DD");
// Flytt notatet til mappen for dagnotater (fra Periodic Notes), uansett hvor Obsidian la det
const mappe = app.plugins.getPlugin("periodic-notes")?.settings?.daily?.folder?.trim() ?? "";
const her = tp.file.folder(true).replace(/^\/$/, "");
if (her !== mappe) await tp.file.move((mappe ? mappe + "/" : "") + tp.file.title);
-%>
---
dato: "<% d.format("YYYY-MM-DD") %>"
uke: "[[<% d.format("GGGG-[uke-]WW") %>]]"
forrige: "[[<% d.clone().subtract(1, "day").format("YYYY-MM-DD") %>]]"
neste: "[[<% d.clone().add(1, "day").format("YYYY-MM-DD") %>]]"
relatert til:
tags:
  - daglig
---

## Dagens notater

