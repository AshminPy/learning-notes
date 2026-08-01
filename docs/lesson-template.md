# Lesson Template — Academy-tier courses (v2, scenario-driven)

Applies to every course built under the "engineering academy" initiative (2026-08-01
onward): Linux, Networking, Git/GitHub, GitOps, Observability, Kubernetes Production,
Vault, AWS Architecture, SRE, Incident Response, AI Platform Engineering,
Elasticsearch, Production Troubleshooting. Existing courses (CKA, PCA, Ansible,
Terraform, AI/ML Engineer, keyboard-workflow) are not retrofitted.

**v2 supersedes v1 (2026-08-01, Ashmin's direction):** the previous version was a
traditional chapter structure ("What is X?" → facts → labs → quiz). That's explicitly
what this academy must NOT be — there are already thousands of courses like that.
Every lesson now teaches HOW A SENIOR ENGINEER THINKS, built around a realistic
production incident, not a topic outline. Theory is introduced only once it's needed
to solve the scenario — never as the opening move.

## The core idea

A learner should never open a lesson to "Today we learn DNS." They should open it to
a broken production system and have to figure out DNS is the answer, the same way a
real engineer would. By the end, they've learned the technology without ever being
told "here are the facts about X" as a starting point.

## Required structure, in order

1. **Eyebrow + title** — the title names the *situation*, not the topic. "The app
   works from your laptop but fails inside Kubernetes" — not "Understanding DNS."
2. **Learning objectives** — framed as capability, not knowledge: "By the end you can
   diagnose X" not "By the end you understand X."
3. **The scenario (cold open)** — a specific, realistic production moment. Time of
   day, what's alerting, what's normal, what's not. Concrete numbers (latency went
   from 80ms to 9s), not vague ("the app is slow"). End with a direct question to the
   reader: "Where do you begin?"
4. **Observe symptoms** — lay out exactly what's known and what's confirmed normal
   (rules things out early, same as a real investigation).
5. **Stop and think (Socratic prompts)** — before any answer is given, ask the reader
   directly: What would you check first? Why? What evidence would support that? What's
   dangerous to assume here? What can this *not* be? Use the `.quiz` reveal pattern so
   the learner commits to their own answer before seeing the reasoning — this is not
   a rhetorical question, it's an active-recall checkpoint.
6. **Build the mental model** — introduce the underlying concept *here*, motivated
   directly by what's needed to keep investigating. This is where old-template
   "mental model" content lives now — never earlier than this.
7. **Generate hypotheses** — list plausible causes explicitly, including at least one
   wrong-but-tempting one. Don't pre-filter to only the right answer.
8. **Investigate** — real commands/tools, step by step, run *in service of* testing
   the hypotheses above — not a standalone drill disconnected from the scenario.
9. **Gather evidence** — show real (or realistic) command output, logs, metrics.
10. **Eliminate wrong assumptions** — walk through why the tempting-but-wrong
    hypothesis from step 7 doesn't hold up against the evidence. This is the step
    most traditional courses skip entirely, and it's the one that teaches elimination
    reasoning instead of memorization.
11. **Root cause** — state it plainly once the evidence actually supports it.
12. **Fix** — apply it.
13. **Explain WHY the fix worked** — tie the fix back to the mental model from step 6.
14. **Prevent recurrence** — best practices / monitoring / production checklist live
    here, framed as "how do we stop this from happening again," not a generic list.
15. **Widen the lens** — answer, briefly, whatever of these genuinely applies to this
    topic: why does this technology exist, what problem was it built to solve, why
    wasn't the prior solution good enough, what would happen if it disappeared
    tomorrow, when should you absolutely NOT use it. Security/performance/cost
    considerations fold in here as "what changes at 10 users vs 10,000 vs 10 million,"
    "what if compliance requirements changed," "what if cost became the priority" —
    decision-making framed as trade-offs, not a static callout list.
16. **Interview questions** — reuse the `.quiz` reveal mechanic, but frame as
    "explain your reasoning" rather than fact recall.
17. **Certification notes / official references** — brief, only if the course has a
    cert anchor; real links only, verified.
18. **Recap** — the mental model and the diagnostic method, not a bullet restating
    every fact mentioned.
19. **Progressive challenge ladder** — replaces the old single "practical challenge":
    - **Level 1** — fix a simple, guided problem (confidence builder)
    - **Level 2** — diagnose a production issue with less hand-holding
    - **Level 3** — design a better architecture given the failure mode just learned
    - **Level 4** — explain your reasoning (written or spoken, no code)
    - **Level 5** — optimize the design for cost, performance, AND reliability
      simultaneously (forces real trade-off thinking, not a single "right answer")

## Non-negotiables
- Never open with "What is X?" — open with a broken system and a clock.
- Theory is introduced only when the investigation needs it, never before.
- Always include at least one deliberately wrong-but-plausible hypothesis, and
  explicitly show why it's eliminated — this is the single most important habit
  the academy is trying to build.
- Every "why does this exist" answer must be genuine, not decorative — if a lesson
  can't honestly answer "what would happen if this disappeared tomorrow," that's a
  sign the technology/lesson pairing needs rethinking, not a section to fake.
- Diagrams (Mermaid), when used, illustrate the system *as it's being investigated*,
  not an abstract architecture diagram disconnected from the scenario.
- Every technical/API/exam claim verified against official docs or man pages — cited,
  never presented from memory.
- Simple language first, depth builds progressively — never gatekeep with jargon
  before it's explained, even inside an investigation narrative.
- A few genuinely reference-heavy topics (e.g. a pure command/flag reference) may not
  fit a full incident narrative — for those, still open with a concrete "here's when
  you'd reach for this" situation rather than a bare topic statement, but don't force
  a fake incident where a short situational frame is more honest.
