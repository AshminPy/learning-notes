# Roadmap — Future Improvements (Post-v1)

The site now spans 6 topics (`gcp-pca` 28 lessons, `kubernetes-cka` 24, `ansible` 36, `terraform` 37, `ai-ml-engineer` 34, `keyboard-workflow` 8) and is published/production-ready. The items below are planned enhancements, not bug fixes or blockers — they're tracked here so they aren't lost between sessions. Apply these principles to every topic, not just CKA/PCA.

**Goal:** keep evolving this into one of the highest-quality free revision resources for CKA and PCA, while staying simple, accurate, and easy to maintain.

## Guiding principles (apply to everything below)
- Accuracy before completeness.
- Prefer official documentation over third-party sources.
- Avoid unsupported claims.
- Keep the interface lightweight and fast.
- Preserve the clean design.
- Avoid unnecessary JavaScript frameworks.
- Keep everything mobile-friendly.
- Position the site as a revision/active-recall companion, not a replacement for official docs or hands-on experience.

## 1. Official references on every lesson (highest priority)
Every lesson ends with an "Official References" section — deep links to the exact topic (not doc homepages), plus a "Last reviewed" date that's easy to update. Improves trust, encourages verification, reduces long-term maintenance risk.

## 2. Curriculum/version badges
Near the lesson title: which curriculum version was used (e.g. "Kubernetes v1.35" / "Official PCA Exam Guide") and when it was last reviewed. Minimal styling, no implied official endorsement.

## 3. Site-wide search
Client-side, no backend, fast, mobile-friendly. Searches lesson titles, keywords, active-recall questions, command examples, service names.

## 4. Lesson difficulty badges
🟢 Beginner / 🟡 Intermediate / 🔴 Exam Critical — helps prioritize revision, reduces cognitive load.

## 5. Estimated review time per lesson
E.g. "≈ 8 minutes" — helps plan study sessions.

## 6. Recommended hands-on labs per lesson
"Practice" section linking to Killercoda, KodeKloud, Google Skills Boost, official docs examples. Only labs directly related to that lesson; prefer free resources; clearly distinguish official vs. third-party.

## 7. Improved lesson metadata block
Consolidate: last reviewed, difficulty, review time, official references, recommended lab, exam domains covered.

## 8. "Recently Updated" page
A changelog-style page (e.g. "Version 1.1 — added Storage lessons, updated Vertex AI section...") so returning users can see what's new without re-reading everything.

## 9. Further accessibility work
Target WCAG 2.1 AA where practical: keyboard navigation, screen readers, color contrast, focus indicators, semantic headings, ARIA attributes, accessible names. (Checkbox aria-labels already done as of 2026-07-27.)

## 10. Printable cheat sheets
One-page, print-friendly, PDF-friendly, black-and-white-compatible summaries per topic area (e.g. CKA Storage/Networking/Security, GCP IAM/Networking/Compute/Storage).

## 11. Mobile reading experience pass
Review spacing, typography, tap targets, code blocks, tables, horizontal scrolling — optimize specifically for phones. (Wide-table horizontal scroll already fixed as of 2026-07-27; this is a broader follow-up pass.)

## 12. Study roadmap / guided learning path
An optional linear path (e.g. Pods → Deployments → Services → Ingress → Storage → Security → Final Review for CKA) as an alternative to the objectives tracker — doesn't replace it, just gives a guided option for beginners.

## 13. Interview mode (future)
Toggle from revision mode to "explain this concept out loud, then reveal the expected answer" — makes the notes useful beyond certification prep.

## 14. Spaced-repetition support (future)
Mark lessons Again / Hard / Good / Easy, stored in localStorage, surface what's due for review. No account or backend.

---

*Prioritization, sequencing, and scoping of these items is a design conversation to have per-item when picked up — this file just prevents the ideas from being lost.*
