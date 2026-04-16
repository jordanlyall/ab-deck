# Using ab-deck on Claude Cowork

Guide for using ab-deck in Claude's web interface (claude.com/code or claude.ai) without installing anything locally.

---

## The short version

1. Open claude.ai (or Claude Cowork if you have access)
2. Start a new chat
3. Paste the prompt from [`PROMPT.md`](PROMPT.md)
4. Then paste the template from [`templates/deck-shell.html`](templates/deck-shell.html)
5. Then paste your outline
6. Claude returns complete HTML
7. Copy the HTML, save as `my-deck.html`, open in your browser

---

## Step by step

### 1. Open Claude

Go to **https://claude.ai** (or Claude Cowork if your team has it) and start a new chat.

### 2. Paste the prompt

Visit **https://github.com/jordanlyall/ab-deck/blob/main/PROMPT.md**, click **Raw**, then Cmd+A / Cmd+C to copy the whole thing.

Paste it into Claude as your first message.

Claude will acknowledge and wait for your template + outline.

### 3. Paste the template

Visit **https://github.com/jordanlyall/ab-deck/blob/main/templates/deck-shell.html**, click **Raw**, Cmd+A / Cmd+C.

Paste as your next message. Tell Claude:
> *"That's the template. I'll send the outline next."*

### 4. Paste your outline

Copy one of the examples to start:

- [Art Tank pitch](examples/art-tank-pitch.md)
- [Team update](examples/team-update.md)
- [Quarterly review](examples/quarterly-review.md)

Edit the placeholder text to fit your deck. Paste the full outline as your next message, with:
> *"Here's my outline. Please build the HTML deck."*

### 5. Get the HTML

Claude returns a single HTML block. The block will be long (~500 lines). Click the **Copy** button on the code block.

### 6. Save and open

Open your text editor (TextEdit in Plain Text mode, VS Code, or anything else). Paste. Save as `my-deck.html` anywhere — your Desktop is fine.

Double-click the file in Finder. It opens in your default browser. You should see the title slide.

**Navigation**: arrow keys, scroll, touch swipe. Dots on the right. Progress bar up top.

### 7. Export to PDF

In your browser:
- `Cmd+P` → **Save as PDF** → **Landscape** → Save.

Each slide becomes one page. PDF renders in dark mode automatically.

---

## Tips

- **Outline tight first**: edit your outline in a regular text editor or notes app before pasting into Claude. The outline is the deck.
- **Iterate on wording**: after the first HTML, you can ask Claude *"on slide 3, change the heading to..."* and it will return the updated HTML.
- **Start from an example**: don't write an outline from scratch the first time. Copy the closest example and change the text.
- **Save your outline**: keep the markdown outline in a document. Much easier to edit and rebuild than the HTML.

---

## If something breaks

- **Fonts look generic**: your browser is blocking Google Fonts. The deck still works — the fallback is `system-ui`.
- **Chromie gradient missing**: your browser may not support CSS `background-clip: text` well. Safari handles it best. Chrome works. Firefox partially.
- **PDF looks wrong**: make sure "Landscape" is selected in print dialog.
- **Claude returns incomplete HTML**: ask *"Please return the complete HTML again, all the way through the closing `</html>` tag."*

---

## What about Claude Code?

If you have the Claude Code CLI installed locally, you don't need this guide. Just `git clone` the repo, run `./install.sh`, and ask Claude *"use ab-deck"* in any session. See the main README.

---

## Questions

Ping @jordanlyall on Slack.
