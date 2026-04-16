# Using ab-deck on Claude Cowork

If you're on Claude Cowork (claude.com/code), this is the easiest path. Cowork can pull files directly from GitHub and save the deck as a file you can click to open.

---

## The smooth flow

### 1. Start a new Cowork chat

Go to **https://claude.com/code** and start a new session.

### 2. Kick it off with one message

Paste this:

> *"I want to use ab-deck from https://github.com/jordanlyall/ab-deck to build a deck. Pull the PROMPT.md and templates/deck-shell.html from the repo. Then use this outline:"*

Then paste your outline below the message (see examples below).

### 3. Claude builds it

Cowork fetches the prompt + template from GitHub, renders your outline into a complete HTML deck, and saves it to your outputs folder as a clickable link.

### 4. Open, present, iterate

- **Open**: click the `.html` file in Cowork to open in your browser
- **Navigate**: arrow keys, scroll, or touch swipe
- **Iterate**: just say *"change slide 3 heading to X"* — Cowork edits the saved file in place
- **PDF**: Cmd+P → Landscape → Save as PDF

---

## Starting from an example

Don't start an outline from scratch. Grab one from the repo and edit:

- **Art Tank pitch** (5 slides): https://github.com/jordanlyall/ab-deck/blob/main/examples/art-tank-pitch.md
- **Team update** (6 slides): https://github.com/jordanlyall/ab-deck/blob/main/examples/team-update.md
- **Quarterly review** (8 slides): https://github.com/jordanlyall/ab-deck/blob/main/examples/quarterly-review.md

Even easier: just tell Cowork *"start from the team-update example and change [X]"* — it'll fetch that example, edit in place, and render.

---

## Plain claude.ai (no Cowork)

If you're on regular claude.ai (not Cowork — no tool execution), the flow is the same but manual:

1. Open https://claude.ai
2. Paste [PROMPT.md](https://github.com/jordanlyall/ab-deck/blob/main/PROMPT.md) (click Raw to copy)
3. Paste [templates/deck-shell.html](https://github.com/jordanlyall/ab-deck/blob/main/templates/deck-shell.html) (click Raw to copy)
4. Paste your outline
5. Claude returns complete HTML
6. Copy the code block, save as `my-deck.html` in a text editor, double-click to open

---

## Tips

- **Write your outline somewhere else first** — Notion, Apple Notes, a text file. The outline is the deck.
- **Iterate on wording**: *"Slide 2 subhead should be X instead"* works, Cowork edits in place.
- **Save your outline**: keep the markdown alongside the HTML. Rebuilding is 10 seconds if you have the outline.

---

## If something breaks

- **Cowork can't fetch GitHub**: drop into claude.ai instead and use the manual paste flow above.
- **Fonts look generic**: your browser is blocking Google Fonts. The deck still works — falls back to system fonts.
- **Chromie gradient missing**: Safari renders it best. Chrome works. Firefox partially.
- **PDF looks off**: check "Landscape" orientation in print dialog.
- **Claude returns incomplete HTML**: ask *"return the complete HTML through the closing `</html>` tag."*

---

## What about Claude Code CLI?

If you have Claude Code installed locally, you don't need this guide. Clone the repo, run `./install.sh`, and just ask *"use ab-deck"* in any session. See the main README.

---

## Questions

Ping @jordanlyall on Slack.
