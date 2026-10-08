# Weekly and daily notes in Obsidian

A simple setup for daily and weekly notes:

- **The weekly note** shows every daily note in the week, Monday to Sunday, plus a table of the notes you worked on that week.
- **The daily note** links to its week, to yesterday and to tomorrow.
- Click a day in the weekly note that doesn't exist yet, and the daily note is created with the right template in the right folder.

- **The homepage** opens this week's note every time you start Obsidian, so you land straight in the current week.

The setup uses three plugins, [Periodic Notes](https://github.com/liamcain/obsidian-periodic-notes), [Templater](https://github.com/SilentVoid13/Templater) and [Homepage](https://github.com/mirnovov/obsidian-homepage). All three are already included in this vault.

## Getting started

### 1. Open in Obsidian
1. Unzip the file and move the folder somewhere permanent. If this is your first time using Obsidian, choose **Open folder as vault** and select the folder. If you already have a vault, click the vault name in the bottom left, choose **Manage vaults…** and then **Open folder as vault**.
2. Click **Trust author and enable plugins** when Obsidian asks.

### 2. Two settings you have to set yourself
These are stored on your computer, not in the vault, so they can't be included:

1. **Language:** see [Language and week start](#language-and-week-start) below.
2. **Templater:** go to *Settings → Templater* and turn on **Trigger Templater on new file creation**. Templater asks whether you trust the vault. Answer yes.

### 3. Try it
Press **Cmd + P** (Mac) or **Ctrl + P** (Windows) and run **Periodic Notes: Open weekly note**. This week's note is created in `journal/weeks/`. Click today to create the daily note.

## Language and week start

The setup assumes that weeks start on **Monday** and uses ISO week numbers. The week start comes from Obsidian's language (*Settings → General → Language*):

- **English:** choose **English (GB)**, not *English*. Plain *English* follows the US convention where weeks start on Sunday, and then you end up in the wrong weekly note. *English (GB)* keeps the interface in English but starts the week on Monday.
- **Most other European languages**, such as Norwegian, German or French, already start the week on Monday. You don't need to do anything.

Restart Obsidian after changing the language.

> Want to keep plain *English*? Install the [Calendar](https://github.com/liamcain/obsidian-calendar-plugin) plugin and set *Start week on* to **Monday**.

## How it fits together

```
templates/
  weekly.md         ← weekly template (filled in by Periodic Notes)
  daily.md          ← daily template (filled in by Templater)
journal/
  2026-10-08.md     ← daily notes
  weeks/
    2026-week-41.md ← weekly notes
```

| What | Who creates the file | Who fills in the content |
|---|---|---|
| Weekly note | Periodic Notes | Periodic Notes, using `weekly.md` |
| Daily note via *Open daily note* | Periodic Notes (empty file) | Templater, using `daily.md` |
| Daily note via a click in the weekly note | Obsidian (empty file) | Templater, using `daily.md` |

- **The weekly template** only uses placeholders that Periodic Notes understands on its own, such as `{{monday:YYYY-MM-DD}}`. It doesn't need Templater.
- **The daily template** uses Templater, because Periodic Notes isn't involved when you click a link. Templater reads the date from the file name, so the note is correct for any day, not just today.
- **Daily notes always end up in the right folder.** When you click a link, Obsidian puts the file wherever you've chosen for new notes. The daily template then moves it to the daily notes folder set in Periodic Notes. To use a different folder, you only change it in Periodic Notes.

## Using the setup in an existing vault

1. Copy the `templates/` folder (or just `weekly.md` and `daily.md`) into your vault.
2. Install **Periodic Notes**, **Templater** and **Homepage** under *Settings → Community plugins → Browse*.
3. Fill in the settings below. Don't copy the `.obsidian` folder, as that would overwrite your existing settings.
4. Read [Language and week start](#language-and-week-start).

If you already have a template folder in Templater, you can put `weekly.md` and `daily.md` there and use those paths instead. Remember to also change `"templates"` in the base block at the bottom of `weekly.md`, so the templates don't show up in the table.

### Settings

**Periodic Notes**

| Setting | Value |
|---|---|
| Daily Notes → Format | `YYYY-MM-DD` |
| Daily Notes → Folder | `journal` (or your own folder) |
| Daily Notes → Template | *empty*. Templater fills in the daily note |
| Weekly Notes → Format | `GGGG-[week-]WW` |
| Weekly Notes → Folder | `journal/weeks` (or your own folder) |
| Weekly Notes → Template | `templates/weekly` |

**Templater**

| Setting | Value |
|---|---|
| Template folder location | `templates` |
| Trigger Templater on new file creation | on |
| Mode | *File regex templates* |
| File regex template | `(^\|/)\d{4}-\d{2}-\d{2}\.md$` → `templates/daily.md` |

The rule means only files named exactly as a date, such as `2026-10-08.md`, get the daily template. Other new notes are not affected.

**Homepage**

| Setting | Value |
|---|---|
| Homepage → Type | *Weekly Note* (uses the weekly note from Periodic Notes) |
| Open on startup | on |
| Open when empty | on |
| Use when opening normally | off |
| Separate mobile homepage | off |
| Opening method | Replace all open notes |
| Manual opening method | Keep open notes |
| Pin | on |
| Hide release notes | on |
| Auto-create | off |

**Obsidian**

- Turn off the core plugin **Daily notes** (*Settings → Core plugins*), so only Periodic Notes manages daily notes.

<details>
<summary><strong>Slightly more advanced: Already using folder templates in Templater?</strong></summary>

Templater can only use one mode at a time: either *Folder templates* or *File regex templates*. If you already use folder templates, keep them. Add the daily template as folder templates instead of the regex rule above.

When you click a day in the weekly note, Obsidian creates the file wherever new notes go (*Settings → Files and links → Default location for new notes*). So the daily template has to apply to that folder too:

| Folder | Template | Used when |
|---|---|---|
| `journal` | `templates/daily.md` | *Open daily note* |
| Your folder for new notes, e.g. `Inbox` (or `/` if new notes go to the vault root) | `templates/inbox.md` (see below) | Clicking a day in the weekly note |

Create `templates/inbox.md`. It sends notes named as a date to the daily template, which moves them to `journal/`. Other new notes are left alone:

```
<%*
if (/^\d{4}-\d{2}-\d{2}$/.test(tp.file.title)) {
  tR += await tp.file.include("[[daily]]");
}
-%>
```

If your folder for new notes already has a folder template, add it as an "else" so it's still used for regular notes:

```
<%*
if (/^\d{4}-\d{2}-\d{2}$/.test(tp.file.title)) {
  tR += await tp.file.include("[[daily]]");
} else {
  tR += await tp.file.include("[[your usual template]]");
}
-%>
```

Subfolders without their own folder template inherit the template from the folder above. If `journal/` has subfolders where you create other notes, give them their own folder template.

</details>

## Troubleshooting

- **"Open weekly note" opens last week, or Sunday is wrong:** your week starts on Sunday. See [Language and week start](#language-and-week-start).
- **A daily note is created but empty:** check that *Trigger Templater on new file creation* is on and that the regex rule points to `templates/daily.md`. If the file was already created empty, delete it and create it again.
- **"… is not created yet. Click to create" in the weekly note:** that's normal for days that don't have a note yet. Click to create it.
- **Odd values like `{{monday:YYYY-MM-DD}}` or `<% … %>`:** you're looking at the template itself. The placeholders are only filled in when a note is created from it.

## Plugins and licenses

This vault contains unmodified copies of these plugins, so the setup works right away. You can update them as usual under *Settings → Community plugins*.

| Plugin | Version | License | Source code |
|---|---|---|---|
| Periodic Notes | 0.0.17 | MIT | [github.com/liamcain/obsidian-periodic-notes](https://github.com/liamcain/obsidian-periodic-notes) |
| Templater | 2.25.0 | AGPL-3.0 | [github.com/SilentVoid13/Templater](https://github.com/SilentVoid13/Templater) |
| Homepage | 4.5.0 | MIT | [github.com/mirnovov/obsidian-homepage](https://github.com/mirnovov/obsidian-homepage) |
