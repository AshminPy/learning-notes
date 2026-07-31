# Learning Notes — Style Guide

This is the canonical spec for every course on this site. Read this before writing a single lesson. The goal: a learner should not be able to tell that different courses were written at different times — same structure, same terminology, same quality bar, same feel.

Written 2026-07-31, after an audit of the first six courses (gcp-pca, kubernetes-cka, keyboard-workflow, ai-ml-engineer, terraform, ansible) found the underlying pattern was real but undocumented — this file makes it explicit so it stops drifting.

## Workspace layout

One folder per course under `~/projects/learning/<course>/`, matching the `/teach` skill's convention:

```
<course>/
  MISSION.md          (gitignored — internal planning, why this course exists)
  RESOURCES.md         (gitignored — trusted sources used for citations)
  NOTES.md              (gitignored — working notes, accent color, decisions)
  objectives.html      (public — certification-domain tracker, see below)
  index.html            (public — course landing page + lesson list)
  assets/style.css     (public — thin @import + theme-token file, see CSS section)
  lessons/
    0001-slug.html
    0002-slug.html
    ...
  reference/            (optional — cheat sheets, glossaries)
  learning-records/     (gitignored — non-obvious learner insights, rarely used on this site)
```

Lesson files are numbered sequentially, zero-padded to 4 digits, `NNNN-dash-case-slug.html`.

## Lesson skeleton

Every lesson follows this section order. Don't skip sections; don't reorder them.

1. `<p class="eyebrow">Course Name</p>`
2. `<h1>` — the lesson title
3. Opening hook paragraph (1-3 sentences: state the goal, name the current gap, frame why this lesson matters)
4. Opening callout — a **Mental model** or **Simple example** (see Callout Taxonomy below). Pick whichever framing fits the concept; they're interchangeable as an opener, don't force one.
5. Body — one or more `<h2>` concept sections: prose, `<table>`, `<pre><code>` blocks, and callouts as needed
6. `<h2>Try it — before looking below</h2>` — one or more `.quiz` blocks (see Quiz Format below)
7. Optional `<h2>Now write your own</h2>` — a real hands-on exercise the learner runs themselves, where the topic supports it
8. `<h2>Source</h2>` — citation to the primary official source for this lesson's claims, dated "verified <date>"
9. `<div class="recap">` — a short bulleted summary
10. `<footer class="teacher-reminder">` — an italic, personal-tutor-voice line inviting the learner to paste real errors/questions back to their teacher (the agent)
11. `<div class="lesson-nav">` — prev/next links

## Callout taxonomy

Six categories. Every callout on the site must be one of these — never invent a seventh, never leave a warning as a bare, unlabeled `.callout`.

| Category | Lead-in text | CSS class | Use for |
|---|---|---|---|
| Mental model | `<strong>Mental model:</strong>` | `.callout` | An analogy that reframes the concept in familiar terms |
| Simple example | `<strong>Simple example:</strong>` | `.callout` | A short, concrete worked example — interchangeable with Mental model as an opener |
| Common mistake | `<strong>Common mistake:</strong>` | `.callout.mistake` | A conceptual pitfall, independent of any exam — something people get wrong in real usage |
| Exam tip | `<strong>Exam tip:</strong>` | `.callout.exam-tip` | An exam-specific gotcha, trap, or scenario pattern. (`.trap` is kept as a permanent CSS alias for `.callout.exam-tip` — older lessons using `class="trap"` never need to be touched.) |
| Security note | `<strong>Security note:</strong>` | `.callout.security` | Anything touching credentials, secrets, access control, data exposure |
| Production note | `<strong>Production note:</strong>` | `.callout.production` | How this is actually used/decided on a real team, at scale, under real constraints |

## Quiz format

Exactly two supported markups. Don't invent a third.

**Free-text recall (default):**
```html
<div class="quiz">
  <p>Q: ...</p>
  <input type="text" id="qN" placeholder="type your answer">
  <button onclick="...">Reveal</button>
  <div class="answer" id="aN">...</div>
</div>
```

**Multiple choice** (for scenario-based questions and practice exams, where the real certification exam is genuinely MCQ):
```html
<div class="quiz">
  <p>Q: ...</p>
  <div class="opts">
    <label>A. ...</label>
    <label>B. ...</label>
    <label>C. ...</label>
    <label>D. ...</label>
  </div>
  <button onclick="...">Reveal answer</button>
  <div class="answer">...</div>
</div>
```
Do not use `<ol type="A"><li>` for MCQs — that markup exists in one legacy lesson (`terraform/lessons/0036-practice-scenarios.html`) and is deprecated; don't propagate it.

**Equal-length-options rule (hard rule, not a suggestion):** every MCQ option must be roughly the same word/character count. The correct answer must never be identifiable by being the longest, most detailed, or most hedged option. Put justification in the revealed `.answer` div, never in the option text itself. This restates `~/.claude/skills/teach/SKILL.md`'s existing quiz rule at the site level, because a real lesson violated it (terraform 0036 — every correct answer was the longest option by a wide margin, letting a test-taker win by length alone instead of knowledge).

## Practice-exam requirement

Every course anchored to a real certification ends with one dedicated practice-exam lesson: a timed-format simulation matching the real exam's actual question count and format (MCQ, per the rule above). This is distinct from "final review" (a cheat-sheet/reference lesson with no new quiz) and from a shorter "practice scenarios" lesson (a handful of illustrative scenario questions). As of this writing no course has a real practice exam yet — every new course must build one; existing courses get one only when they're next revisited for other reasons, not retrofitted on their own.

## Certification-checklist rule

`objectives.html` must be a real tracker, not a decorative one. Use a `DOMAINS` array shaped like:
```js
{ key: "...", name: "<the certifying body's own domain name, verbatim>", weight: <real percentage from the official exam guide>, lessons: [...] }
```
Reproduce the certifying body's actual domain names and weights — don't invent a bespoke thematic structure (phases like "A. Fundamentals, B. Advanced..." look organized but tell the learner nothing about how the real exam is weighted). `gcp-pca/objectives.html` and `kubernetes-cka/objectives.html` are the reference pattern to copy. If a course spans multiple certifications with incompatible domain structures (as `ai-ml-engineer` does), a looser thematic structure is the honest fallback — but default to a real domain map whenever there's one clean cert to map to.

## Citations

Every lesson ends with a `<h2>Source</h2>` section linking the primary official source for its claims (vendor docs, not third-party blogs), dated "verified <date>". This is the site's strongest existing convention (~90-100% of lessons across all six courses already do this) — keep it exactly as-is on every new lesson.

## Voice

Second-person, direct, warm-but-brisk. State the goal, name the current gap, teach the concept, give one worked example, then hand it to the learner to try. Simple English, short sentences — this site's audience includes complete beginners in a given topic even when they're experienced engineers in adjacent areas. Every lesson's teacher-reminder footer should invite real questions — the agent is the learner's tutor, not just a document author.

## Diagrams

None exist on this site today, deliberately. Keep the current all-text/table visual approach (tables for comparisons/matrices, prose for flow, code blocks for syntax) rather than adding images or SVGs. This was a considered decision (2026-07-30), not an oversight — don't reintroduce diagrams without it being an explicit, separate decision.

## CSS

Never hand-roll a new per-course stylesheet. Every course's `assets/style.css` is a thin file:
```css
@import url("../../assets/course-style.css");
:root {
  --accent: #______;    /* pick a color visually distinct from every other course's accent */
  --code-bg: #______;
  /* only add body/h2/h3/table overrides here if this course intentionally departs from the
     shared defaults in ~/projects/learning/assets/course-style.css — most courses need none */
}
@media (prefers-color-scheme: dark) {
  :root { --accent: #______; --code-bg: #______; }
}
```
`~/projects/learning/assets/course-style.css` holds every shared class-level rule (`.callout` and its modifiers, `.quiz` in both variants, `.recap`, `.lesson-nav`, `footer.teacher-reminder`, base typography, the print stylesheet). Adding a new callout modifier or component belongs there, once, not copy-pasted per course.

## Guiding principles (carried forward from ROADMAP.md)

- Accuracy before completeness. Prefer official documentation over third-party sources. Avoid unsupported claims.
- Keep the interface lightweight and fast — no JavaScript frameworks, no build step.
- Keep everything mobile-friendly.
- Position every course as a revision/practice companion, not a replacement for official docs or real hands-on experience — say so explicitly in each course's `index.html` disclaimer.
