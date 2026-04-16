# AB Deck

Internal presentation generator. AB-branded HTML decks from markdown outlines.

## For Claude Code users

Just ask: *"make me a deck for the Q2 review"* or *"build an Art Tank pitch using ab-deck"* — the skill activates automatically.

## For non-Claude-Code team members

Three ways to use this:

### Option 1: Copy an example and edit the HTML directly

The fastest path if you just need a one-off deck:

1. Copy `templates/deck-shell.html` to your Desktop
2. Open it in a text editor (VS Code, TextEdit, whatever)
3. Find `<!-- SLIDES -->` and replace with slide HTML from `templates/deck-shell.html`'s CSS reference comments
4. Save, open in browser, present via screen-share
5. Print to PDF if needed (Cmd+P → Save as PDF, landscape)

### Option 2: Use any Claude interface (claude.ai, Cursor, etc.)

1. Copy the contents of `SKILL.md` as your first message/prompt
2. Copy `templates/deck-shell.html` as attached context
3. Paste your outline (see `examples/` for format)
4. Claude returns complete HTML
5. Save as `.html`, open in browser, present

### Option 3: Run it via this repo

If you have the skill installed locally:

```bash
# Generate PDF from an existing deck HTML
~/.claude/skills/ab-deck/build.sh path/to/deck.html
```

## Outline format

Markdown with YAML frontmatter and slide blocks:

```markdown
---
title: Deck Title
output: filename-without-extension
preset: ab-dark
---

## slide: title
meta: Your Meta | Date
headline: Big [[highlighted text]] headline.
subhead: Supporting line.

## slide: divider
label: Section 1
word: Look Back.
subhead: Short thesis.

## slide: split
label: A1
heading: Section heading.
subhead: One-line description.
bullets:
  - "**Lead bold.** Dim supporting text."
  - "**Next bold.** Next dim."
```

See `examples/` for complete working outlines.

## Slide types

- `title` — full-viewport opener
- `agenda` — three-card overview
- `divider` — full-bleed section break
- `split` — aside + bullet list (workhorse)
- `centered` — presenter handoff or single statement
- `manifesto` — single-line thesis at display scale
- `table` — bucket-style with optional goal callout

See `SKILL.md` for field reference on each.

## Syntax cheatsheet

- `[[text]]` = Chromie gradient highlight (use sparingly, one per slide max)
- `**text**` = bold leader on a bullet
- Everything after `**bold.**` on a bullet wraps in dim styling automatically

## Output conventions

- HTML + PDF save to `~/Desktop/{output}.html` and `~/Desktop/{output}.pdf`
- PDF is landscape, dark mode, one slide per page, no browser chrome
- HTML is self-contained (inline CSS + JS) — share via email or Slack attachment

## Distribution tip

Share the PDF for async review. Share the HTML for live presentation (arrow keys or scroll to navigate, dots on right to jump, progress bar at top).
