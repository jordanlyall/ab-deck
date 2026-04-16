# ab-deck

Internal AB-branded presentation generator. Turn a markdown outline into a polished HTML deck + PDF that looks like the team's quarterly reviews.

Space Grotesk typography. Chromie gradient accents. Landscape dark-mode PDF export. Zero slide-deck software required.

---

## Quick start

### If you're on Claude Code

1. Clone and install:
   ```bash
   git clone git@github.com:jordanlyall/ab-deck.git
   cd ab-deck
   ./install.sh
   ```
2. In any Claude Code session, just ask:
   > *"Use ab-deck to make me an Art Tank pitch deck for [project name]."*
3. Claude will read the skill, ask clarifying questions if needed, generate the HTML to `~/Desktop/`, and optionally run `build.sh` to produce the PDF.

### If you're not on Claude Code

Three paths, pick whichever fits:

**1. Use any Claude interface (claude.ai, Cursor, ChatGPT + Claude model, etc.)**

- Copy the full contents of `SKILL.md` into your first message
- Attach or paste `templates/deck-shell.html` as reference
- Paste your outline (see format below)
- Claude returns complete HTML — save it as `my-deck.html`, double-click to open
- For PDF: browser → Cmd+P → Save as PDF (landscape orientation)

**2. Start from an example and edit manually**

- Copy any file from `examples/` (e.g., `team-update.md`)
- Change the content to your own
- Paste into any AI chat with SKILL.md as context
- Get HTML back, save and open

**3. Edit the HTML template directly (no AI)**

- Copy `templates/deck-shell.html` to your Desktop
- Open in any text editor
- Find `<!-- SLIDES -->` and replace with slide HTML (patterns documented in SKILL.md)
- Save, open in browser, present

---

## What you get

- **HTML deck**: self-contained single file, scroll-snap nav, arrow keys, progress bar, dots nav, ~400KB
- **PDF**: landscape, dark mode, one slide per page, no browser chrome (optional, via `build.sh`)
- Renders well on shared screens during Zoom / Meet / in-person presentations
- Auto-switches between light and dark based on system preference (live view)
- PDF is always dark mode (best for remote sharing)

---

## Outline format

Markdown with YAML frontmatter and slide blocks:

```markdown
---
title: Your Deck Title
output: your-deck-filename
preset: ab-dark
---

## slide: title
meta: Quarterly Review | Q2 2026
headline: Q1 landed. [[Q2 is loaded.]]
subhead: A dense quarter behind. A focused one ahead.

## slide: split
label: A1
heading: New Visitor Experience.
subhead: Nothing else matters if people bounce.
bullets:
  - "**The gap.** 88 of 100 visitors leave without doing anything."
  - "**The wave.** Non-crypto users arriving this summer."
  - "**Q2's job.** Build the front door."
```

### Syntax cheatsheet

- `[[text]]` → wraps text in the Chromie gradient highlight. Use sparingly, one per slide max.
- `**bold.**` at the start of a bullet → renders as a bold leader; everything after wraps in dim secondary styling.
- `<br/>` in headings → forces a line break.

### Slide types

All slide types and their fields are documented in `SKILL.md`. The 7 types are:

| Type | Use for |
|------|---------|
| `title` | Deck opener. Big headline + meta line + corner marks. |
| `agenda` | 3-card overview grid. |
| `divider` | Full-bleed section break ("Look Back.", "Q&A.", etc.) |
| `split` | Workhorse content slide. Aside + bullet list. |
| `centered` | Presenter handoff ("Madeline · 5 min") or single-statement slide. |
| `manifesto` | Single-line thesis at display scale. Use once per deck, max. |
| `table` | Bucket mapping or structured data with optional goal callout. |

See `examples/` for complete working outlines across common use cases.

---

## Examples

| File | Use case |
|------|----------|
| `examples/quarterly-review.md` | Team quarterly. Three-act structure (Look Back / Look Forward / Q&A). |
| `examples/art-tank-pitch.md` | 5-slide Product Lab pitch format. What it is, who it's for, which filter it passes. |
| `examples/team-update.md` | Monthly or weekly all-hands. Shipped / Ahead / Q&A. |

Fork the closest example and edit from there.

---

## Generating the PDF

After generating the HTML, run:

```bash
./build.sh ~/Desktop/my-deck.html
```

This opens Chrome in headless mode, renders the deck in landscape dark mode with one slide per page, and opens the resulting PDF in Preview.

Requires Google Chrome. If Chrome isn't installed, open the HTML in any browser and use Cmd+P → Save as PDF (landscape) as a fallback.

---

## What's locked (on brand)

These are intentionally not configurable — they're what makes a deck look AB:

- **Typography**: Space Grotesk (body) + JetBrains Mono (labels)
- **Colors**: AB night `#1e1e1e` / day `#f9f9f9`
- **Chromie gradient**: the signature Squiggle-inspired rainbow, used on progress bar, accent bars, and `[[highlight]]` text fill
- **Print CSS**: landscape, forced dark mode for PDF, page-per-slide, no chrome
- **SlideEngine**: arrow key + scroll + touch swipe navigation, dots nav, progress bar

## What's configurable

- All slide content
- `preset`: `ab-dark` (default) or `ab-light`
- `output`: filename

---

## Usage in other Claude environments

The skill is designed to be prompt-portable. To use it outside Claude Code:

1. Open your preferred Claude interface (claude.ai, Cursor with Claude, ChatGPT with Claude model, API)
2. Paste the contents of `SKILL.md` as initial system context or first message
3. Attach `templates/deck-shell.html` (or paste inline if attachments aren't supported)
4. Provide your outline
5. Claude returns complete HTML — save, open in browser, present

This works because SKILL.md is fully self-contained documentation — it includes every slide type, HTML pattern, and rendering rule.

---

## Team usage tips

- **Share the PDF for async review**: stakeholders can read without opening a browser
- **Share the HTML for live presentation**: arrow keys to navigate, progress bar at top, dots on right to jump, counter in bottom-right
- **Present via screen-share**: full-screen the browser tab, works on any call (Zoom, Meet, Discord)
- **No internet required at present time**: HTML is self-contained, fonts are loaded from Google Fonts on open — if presenting offline, just open the deck once with internet first to cache, then you're good

---

## Contributing

This is an AB internal tool. If you have a new slide type, an example deck worth including, or a bug:

- Open an issue describing the change
- Or open a PR against `main`
- Examples in `examples/` are great for documenting patterns — one PR per use case

Scope decisions:
- **New slide types**: yes, as long as they fit the AB aesthetic without breaking the rhythm
- **Alternative color palettes**: no — this is AB-branded, stay on brand
- **Non-AB decks**: fork the repo to your personal space

---

## Repo structure

```
ab-deck/
├── SKILL.md              # full usage + slide type reference (Claude reads this)
├── README.md             # this file
├── LICENSE               # internal-use notice
├── install.sh            # symlinks into ~/.claude/skills/ for Claude Code users
├── build.sh              # HTML → PDF via Chrome headless
├── templates/
│   └── deck-shell.html   # parametric HTML template with all CSS + JS
└── examples/
    ├── quarterly-review.md
    ├── art-tank-pitch.md
    └── team-update.md
```

---

## Origin

Built Apr 15–16, 2026 by extracting the Q2 2026 Quarterly Review deck into a reusable generator. All design decisions (typography, colors, chromie gradient treatment, print CSS, slide engine) come from that deck. Opinionated for AB internal use — non-AB teams should fork.

---

## Questions

Ping @jordanlyall on Slack.
