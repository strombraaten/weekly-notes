# Weekly and daily notes in Obsidian

Get an overview of the week you're in with the weekly view. Take one day at a time with the daily notes. And make it easy to get back, because the week is always your start page.

## Getting started

### 1. Open in Obsidian
1. Unzip the file and move the folder wherever you want to keep it. If this is your first time using Obsidian, choose **Open folder as vault** and open the folder. If you already have a vault open, press Cmd + P (Mac) or Ctrl + P (Windows) to open the command bar, search for **Manage vaults…** and then choose **Open folder as vault**.
2. Click **Trust author and enable plugins** when Obsidian asks.
3. Choose English (GB), or Norwegian, as the language if you want weeks to start on Monday. You can always change this later. See [Language and week start](#language-and-week-start) if you want to understand it better.

### 2. One setting you have to set yourself

Go to *Settings → Templater* and turn on **Trigger Templater on new file creation**. Templater asks whether you trust the vault. Answer yes.

### 3. For a smooth start, restart Obsidian
Quit Obsidian completely (**Cmd + Q** on Mac) and open the vault again. From now on, your weekly view opens as a start page.
It needs a restart to work.

You can always get back to the weekly view with **Alt + W** (Option + W on Mac).

### 4. Voilà! Your overview is ready

To start a daily note, click `"year-month-date" is not created yet. Click to create.`

## Language and week start

The setup assumes that weeks start on **Monday**. This comes from Obsidian's language (*Settings → General → Language*):

- **Choose Norwegian** if you want all of the interface in Norwegian.
- **Choose "English (GB)"**, not *English*, if you want the interface in English. Plain *English* follows the US convention where weeks start on Sunday, and then you end up in the wrong weekly note. *English (GB)* keeps the interface in English but starts the week on Monday.

> If you really want to keep plain *English*, install the [Calendar](https://github.com/liamcain/obsidian-calendar-plugin) plugin and set *Start week on* to **Monday**.

## Want to use the setup in an existing vault?

1. Copy the `templates/` folder (or just these two files, `weekly.md` and `daily.md`) into your vault.
2. Install **Periodic Notes**, **Templater** and **Homepage** under *Settings → Community plugins → Browse*.
3. Fill in the settings below.
4. Read [Language and week start](#language-and-week-start).

If you already use Templater, you can put `weekly.md` and `daily.md` where you keep your other templates. You then have to change the path (that is, where the file is located) at the bottom of `weekly.md`, in the base block.

### Recommended settings

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

<details>
<summary><strong>Slightly more advanced: Already using templates for different folders in Templater?</strong></summary>

Templater can only use one mode at a time: either *Folder templates* or *File regex templates*. If you already use folder templates, keep them. Add the daily template as a folder template instead of the regex rule above.

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

## FAQ

- **The homepage doesn't open:** Press **Alt + W** to go straight to the homepage. Alternatively, open the command bar with **Cmd + P** and start typing "homepage" to open it from there.
- **"Open weekly note" opens last week, or the week starts on Sunday:** See [Language and week start](#language-and-week-start).
- **A daily note is created but empty:** check that *Trigger Templater on new file creation* is on and that the regex rule points to `templates/daily.md`. If the file was already created empty, delete it and create it again.
- **What are the odd values like `{{monday:YYYY-MM-DD}}` or `<% … %>`:** you're looking at the template itself. The placeholders are filled in when you create a new file from it.

## Plugins and licenses

The vault relies on three plugins to make this work, and contains unmodified copies of them, so that it just works automagically.

Now and then they probably need updating, and you do that under *Settings → Community plugins*.

| Plugin | Version | License | Source code |
|---|---|---|---|
| Periodic Notes | 0.0.17 | MIT | [github.com/liamcain/obsidian-periodic-notes](https://github.com/liamcain/obsidian-periodic-notes) |
| Templater | 2.25.0 | AGPL-3.0 | [github.com/SilentVoid13/Templater](https://github.com/SilentVoid13/Templater) |
| Homepage | 4.5.0 | MIT | [github.com/mirnovov/obsidian-homepage](https://github.com/mirnovov/obsidian-homepage) |
