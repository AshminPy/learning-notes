# Lesson Template — Academy-tier courses

Applies to every course built under the "engineering academy" initiative (2026-08-01
onward): Linux, Networking, Git/GitHub, Terraform, GitOps, Observability, Kubernetes
Production, Vault, AWS Architecture, SRE, Incident Response, AI Platform Engineering,
Elasticsearch, Production Troubleshooting. Existing courses (CKA, PCA, Ansible,
Terraform, AI/ML Engineer, keyboard-workflow) are not retrofitted — this is the bar
for new content going forward.

Goal for every lesson: after reading it, a learner can confidently design, deploy,
operate, troubleshoot, and explain the technology in production — not recite facts.

## Required sections, in order, with HTML/CSS mapping

1. **Eyebrow + title** — `<p class="eyebrow">Course / Track — Lesson N of M</p>` + `<h1>`
2. **Learning objectives** — 3-5 bullets, "By the end of this lesson you can..."
3. **Mental model** — the one idea that makes everything else click. `<p class="callout">`
4. **Beginner-friendly explanation** — plain language first, simple example, before any depth
5. **Real-world analogy** — concrete, memorable, inside the mental-model callout or right after it
6. **Diagram(s)** — Mermaid, whenever a diagram genuinely clarifies (architecture, flow,
   decision tree). Wrap in `<div class="mermaid-diagram"><pre class="mermaid">...</pre></div>`.
   Load Mermaid via CDN (`<script type="module">import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs'; mermaid.initialize({startOnLoad:true, theme:'neutral'});</script>`)
   once per lesson, right before `</body>`. Never fabricate a diagram just to have one —
   skip it if prose/table is genuinely clearer.
7. **Production architecture** — how this looks in a real production system, not a toy example
8. **Step-by-step hands-on lab** — `<div class="tryit">`, runnable on a real free/local
   environment, numbered steps, expected output shown
9. **Troubleshooting walkthrough** — at least one realistic failure, structured as:
   Symptoms → Investigation → Root cause → Resolution → Prevention (table or headed
   subsections — see Production Troubleshooting course for the canonical deep version)
10. **Common mistakes** — `<p class="callout mistake">`
11. **Best practices** — `<p class="callout production">`
12. **Security considerations** — `<p class="callout security">`
13. **Performance considerations** — `<p class="callout performance">`
14. **Cost optimization** — `<p class="callout cost">` — only where genuinely applicable
    (skip for topics with no cost dimension, e.g. most of the Linux course; don't force it)
15. **Production checklist** — `<ul class="checklist"><li><input type="checkbox"> ...`
16. **Interview questions** — reuse the `.quiz` reveal pattern (question, "Reveal" button,
    model answer) — same mechanic as the recall quiz, distinct section/heading
17. **Certification notes** — which exam domain(s) this maps to, if the course has a
    certification anchor; skip section entirely if not applicable to this lesson
18. **Official documentation references** — real links, fetched/verified, never guessed
19. **Lesson summary** — `<div class="recap">`
20. **Quiz** — `<div class="quiz">`, active-recall free-text or MCQ (existing pattern)
21. **Practical challenge** — a harder, open-ended task beyond the guided lab, no
    step-by-step hand-holding — this is where the learner proves independent competence

## Topic-level additions (once per major topic, not every lesson)
Cover explicitly, usually in the topic's first lesson or a dedicated "why/when" lesson:
why this technology exists, when to use it, when NOT to use it, alternatives, trade-offs,
common production failures, root cause patterns, decision trees, comparison tables.

## Non-negotiables
- WHY before HOW, every time.
- Every technical/API/exam claim verified against official docs or man pages — cite the
  source, never present memory as fact (matches this site's existing standard).
- Simple language first, depth builds progressively — never gatekeep with jargon before
  it's explained.
- No content forced in where it doesn't apply (e.g. don't invent a fake "cost" section
  for a topic with no cost dimension) — the template is a checklist to consider, not a
  rigid form every box must be filled on every single lesson.
