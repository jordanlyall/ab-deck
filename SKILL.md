---
name: ab-deck
description: Generate polished Art Blocks-branded HTML presentations from a markdown outline. Use when someone on the AB team needs a deck for a quarterly review, team update, Art Tank pitch, all-hands, or any internal presentation. Produces landscape HTML + PDF with AB's Space Grotesk + Chromie gradient aesthetic.
type: skill
---

# AB Deck Skill

Generate self-contained HTML presentations matching the Art Blocks internal deck style. Opinionated on brand (typography, color, signature Chromie gradient). Flexible on content.

## When to use

- User asks to "make a deck" / "build a presentation" / "create slides" for Art Blocks work
- Quarterly reviews, team updates, Art Tank pitches, project briefs, internal pitches
- User mentions "AB style" or wants to match the quarterly deck aesthetic

## How to use

1. Read the user's outline (markdown in the format below)
2. For each slide block, render the matching HTML from the slide type reference
3. Inject all slide HTML into `templates/deck-shell.html` at the `<!-- SLIDES -->` marker
4. Write output to `~/Desktop/{output}.html`
5. Run `~/.claude/skills/ab-deck/build.sh ~/Desktop/{output}.html` to generate matching landscape PDF
6. Open both files

## Input format

Outline is markdown with YAML frontmatter + slide blocks separated by `## slide: TYPE`:

```markdown
---
title: My Deck Title
output: my-deck-filename
preset: ab-dark
---

## slide: title
meta: Quarterly Review | Q2 2026
headline: Q2 Review + Q3 Planning · July 29, 2026

## slide: divider
label: Act 1 · Q1
word: Look Back.
subhead: Twelve weeks. All four buckets moved.

## slide: split
label: A1
heading: New Visitor Experience.
subhead: Nothing else matters if people bounce.
bullets:
  - "**The gap.** 88 of 100 visitors leave without doing anything."
  - "**The wave.** Non-crypto users arriving this summer."
  - "**Q2's job.** Build the front door."
```

**Syntax notes**:
- `[[text]]` wraps text in Chromie gradient highlight
- `**bold**` renders as `<strong>` (use for bullet leaders)
- Bullet text after `**bold.**` becomes dim/secondary (default list style)
- All text is literal — no Markdown processing beyond `[[ ]]` and `**`

## Presets

- `ab-dark` (default) — dark night background, light text, chromie accents
- `ab-light` — light day background, dark text, chromie accents

## Slide types

### title

Full-viewport opener. Corner marks, meta line, chromie bar, display headline, subhead.

**Fields**:
- `meta` (optional) — mono label line, e.g., "Quarterly Review | Q2 2026"
- `corner-tl` (optional) — top-left corner mark
- `corner-br` (optional) — bottom-right corner mark
- `headline` — big display text, supports `[[chromie]]` highlight
- `subhead` (optional) — dim body text

**HTML**:
```html
<section class="slide slide--centered">
  <div class="corner-mark reveal">{corner-tl}</div>
  <div class="corner-mark br reveal">{corner-br}</div>
  <div class="title-meta reveal">
    <span>{meta}</span>
  </div>
  <span class="chromie-bar reveal"></span>
  <h1 class="display reveal" style="max-width: 16ch;">{headline with [[span hl]]}</h1>
  <p class="body-dim reveal" style="margin-top: 40px; max-width: 580px;">{subhead}</p>
</section>
```

### agenda

Three-card overview grid with chromie top bars.

**Fields**:
- `heading` — slide heading
- `cards` — list of `{num, name, desc}` objects

**HTML**:
```html
<section class="slide slide--centered">
  <span class="label reveal">Agenda</span>
  <h2 class="heading reveal" style="margin-top: 16px;">{heading}</h2>
  <div class="agenda-grid reveal">
    <div class="agenda-item">
      <div class="num">{card.num}</div>
      <div class="name">{card.name}</div>
      <div class="desc">{card.desc}</div>
    </div>
    <!-- repeat per card -->
  </div>
</section>
```

### divider

Full-bleed section divider. Big word + chromie bar + optional subhead.

**Fields**:
- `label` — small mono label above (e.g., "Act 1 · Q1")
- `word` — the big divider word (e.g., "Look Back.")
- `subhead` (optional) — dim subhead below chromie bar

**HTML**:
```html
<section class="slide slide--centered">
  <div class="divider-num reveal">{label}</div>
  <h2 class="divider-text reveal">{word}</h2>
  <div class="divider-chromie reveal"></div>
  <p class="divider-desc reveal">{subhead}</p>
</section>
```

### split

Workhorse content slide. Aside (label + heading + subhead) + content list. Use for boulder slides, Q1 ship slides, etc.

**Fields**:
- `label` — mono label (e.g., "A1", "Q1 · 1 of 3")
- `heading` — main heading, can include `<br/>` for line break
- `subhead` — dim subhead
- `bullets` — list of bullet strings (support `**bold**` leaders)
- `footer` (optional) — mono-styled closing line (like "▸ Everything else — Friday")

**HTML**:
```html
<section class="slide">
  <div style="flex: 1; display: flex; align-items: center;">
    <div class="split-layout">
      <div class="split-aside reveal">
        <span class="chromie-bar"></span>
        <span class="label">{label}</span>
        <h3 class="heading" style="margin-top: 16px;">{heading}</h3>
        <p class="body-dim" style="margin-top: 20px; max-width: 380px;">{subhead}</p>
      </div>
      <ul class="content-list reveal">
        <li>{bullet HTML}</li>
        <!-- repeat per bullet -->
        <!-- optional footer: -->
        <li style="margin-top: 24px; padding-left: 0; color: var(--text); font-weight: 500; font-family: var(--font-mono); font-size: clamp(12px, 1.15vw, 15px); letter-spacing: 0.14em; text-transform: uppercase;">▸ {footer}</li>
      </ul>
    </div>
  </div>
</section>
```

**Bullet rendering**: `"**The gap.** 88 of 100 leave."` →
```html
<li><strong>The gap.</strong> <span class="dim">88 of 100 leave.</span></li>
```

### centered

Speaker placeholder (Ryan/Madeline/Jaime pattern) or single-point statement slide.

**Fields**:
- `label` — mono label (e.g., "Finance · Ryan")
- `heading` — short declarative title
- `pill` (optional) — "5 min" or similar
- `subhead` (optional) — dim body text (used for non-placeholder centered slides)

**HTML (placeholder variant)**:
```html
<section class="slide slide--centered">
  <span class="label reveal">{label}</span>
  <h2 class="heading reveal" style="margin-top: 16px; max-width: 16ch;">{heading}</h2>
  <div class="reveal" style="margin-top: 40px;">
    <span class="pill hot"><span class="pdot"></span>{pill}</span>
  </div>
</section>
```

### manifesto

Single-line thesis slide at display scale. Use sparingly for the most important idea in the deck.

**Fields**:
- `label` — mono label above
- `headline` — the big statement, supports `[[chromie]]` highlight
- `subhead` (optional) — supporting kicker

**HTML**:
```html
<section class="slide slide--centered">
  <span class="label reveal">{label}</span>
  <span class="chromie-bar reveal" style="margin-top: 24px; margin-bottom: 32px; width: 120px; height: 5px;"></span>
  <h1 class="display reveal" style="font-size: clamp(64px, 10vw, 140px); max-width: 14ch; line-height: 0.95;">
    {headline with [[hl]]}
  </h1>
  <p class="body reveal" style="margin-top: 48px; max-width: 720px; font-size: clamp(20px, 2.4vw, 34px); font-weight: 400; color: var(--text-dim); letter-spacing: -0.02em; line-height: 1.2;">
    {subhead}
  </p>
</section>
```

### table

Bucket-style table with optional goal callout. Use for strategy mapping, comparison, or ranked lists.

**Fields**:
- `label` — mono label
- `heading` — slide heading with optional `[[chromie]]`
- `body` (optional) — preamble body text
- `table` — `{headers: [col1, col2], rows: [[a, b], [c, d]]}`
- `callout` (optional) — `{num, label}` for the 100K-style dark callout

**HTML**:
```html
<section class="slide slide--centered">
  <span class="label reveal">{label}</span>
  <h2 class="heading reveal" style="margin-top: 16px;">{heading}</h2>
  <p class="body-dim reveal" style="margin-top: 20px; max-width: 860px;">{body}</p>
  <table class="bucket-table reveal">
    <thead><tr>{th per header}</tr></thead>
    <tbody>{tr per row}</tbody>
  </table>
  <div class="goal-callout reveal">
    <div class="goal-num">{callout.num}</div>
    <div class="goal-label">{callout.label}</div>
  </div>
</section>
```

## Rendering instructions for Claude

1. Read `templates/deck-shell.html` — this is the canonical template with all CSS + JS
2. Parse the user's outline into slide blocks
3. For each slide, render the HTML snippet from the matching type above
4. Replace `<!-- SLIDES -->` marker in the shell with concatenated slide HTML
5. Write to `~/Desktop/{output}.html`
6. Tell user to refresh the browser or run `~/.claude/skills/ab-deck/build.sh ~/Desktop/{output}.html` to generate PDF

## Chromie gradient highlight

The `[[text]]` syntax wraps text in:
```html
<span class="hl">text</span>
```

`.hl` is a gradient text fill using the signature AB Chromie palette (green → cyan → blue → magenta → red → yellow). In print/PDF mode it falls back to solid cyan.

## Bold + dim bullet pattern

The standard bullet rhythm is: **Short leader.** Dim body text.

Input: `"**The gap.** 88 of 100 visitors leave without doing anything."`
Output: `<li><strong>The gap.</strong> <span class="dim">88 of 100 visitors leave without doing anything.</span></li>`

Rule: everything after the first `**bold.**` segment wraps in `<span class="dim">`. If no bold leader, the whole bullet is plain text.

## Output conventions

- Default output location: `~/Desktop/{output}.html` and `~/Desktop/{output}.pdf`
- Filename comes from outline's `output:` frontmatter field
- Open both files after generation

## Examples

See `examples/` directory:
- `quarterly-review.md` — full quarterly review (18 slides)
- `art-tank-pitch.md` — 5-min Product Lab pitch format

## For non-Claude-Code users

The skill works in any Claude interface (Claude.ai, Cursor, API) by:
1. Sharing the SKILL.md contents as initial context
2. Sharing the `templates/deck-shell.html` file
3. User pastes outline
4. Claude returns complete HTML
5. User saves locally, opens in browser, prints to PDF if needed

See `README.md` for the standalone team workflow.
