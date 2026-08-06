#!/usr/bin/env bash
# check-course-status.sh — cross-file consistency check for one course.
#
# WHY THIS EXISTS: a course's "how many lessons are published" fact lives in 4
# separate places that must be kept in sync by hand: actual files in lessons/,
# objectives.html's href list, the course's own index.html, and the site-wide
# index.html homepage card. Nothing else checks they agree. This does.
#
# Real incidents this caught (or should have caught, run retroactively):
#   - git-github/index.html said "9 lessons, publishing incrementally" after
#     all 20 were shipped (fixed in PR #48, found by the user, not by us).
#   - git-github/README.md's topic list had stale lesson counts for two
#     other courses entirely (found during autoship discovery).
#   - vault/index.html briefly said "Complete — 28 of 28" with zero lesson
#     files on disk (caught during authoring, before it shipped).
#
# USAGE: ./scripts/check-course-status.sh <course-slug>
#   ./scripts/check-course-status.sh vault
#   ./scripts/check-course-status.sh --all      # check every course dir
#
# Exit code: 0 if every course checked is consistent, 1 if any mismatch found.
# Run this before every "done"/"published"/"complete" claim about a course —
# not just at the end of a whole course, after every lesson-batch too.

set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAIL=0

check_one() {
  local course="$1"
  local dir="$ROOT/$course"
  if [ ! -d "$dir" ]; then
    echo "SKIP $course — no such directory"
    return
  fi

  local actual_lessons obj_hrefs obj_lesson_count idx_li_count idx_status home_status

  actual_lessons=$(find "$dir/lessons" -maxdepth 1 -iname "*.html" 2>/dev/null | wc -l | tr -d ' ')

  local dangling_links=0
  if [ -f "$dir/objectives.html" ]; then
    obj_hrefs=$(grep -oE 'href: "lessons/[^"]+\.html"' "$dir/objectives.html" 2>/dev/null | sort -u | wc -l | tr -d ' ')
    obj_lesson_count=$(grep -oE '\{ id: "[0-9]{4}"' "$dir/objectives.html" 2>/dev/null | wc -l | tr -d ' ')
    # PRECISE check: every href in objectives.html that isn't null must point to
    # a file that actually exists — a count match alone can hide this (e.g. all
    # N entries have hrefs, but 0 of those N files exist yet).
    while IFS= read -r href; do
      [ -z "$href" ] && continue
      if [ ! -f "$dir/$href" ]; then
        dangling_links=$((dangling_links + 1))
      fi
    done < <(grep -oE 'href: "lessons/[^"]+\.html"' "$dir/objectives.html" 2>/dev/null | sed -E 's/^href: "(.*)"$/\1/')
  else
    obj_hrefs="MISSING"; obj_lesson_count="MISSING"
  fi

  if [ -f "$dir/index.html" ]; then
    # grep -c always prints a count (even "0") regardless of exit code — don't
    # add `|| echo 0` here, it double-prints "0\n0" when there are zero matches.
    idx_li_count=$(grep -c '<li><a href="lessons/' "$dir/index.html" 2>/dev/null)
    idx_li_count=${idx_li_count:-0}
    idx_status=$(grep -oE '<p>[0-9]+ (of [0-9]+ )?lessons? (planned|published)[^<]*</p>|Complete — [0-9]+ of [0-9]+ lessons' "$dir/index.html" 2>/dev/null | head -1)
  else
    idx_li_count="MISSING"; idx_status="MISSING FILE"
  fi

  home_status=$(awk -v slug="$course/index.html" '
    /<div class="card">/ { in_card=1; buf="" }
    in_card { buf = buf $0 "\n" }
    /<\/div>/ && in_card {
      if (buf ~ slug) { print buf; exit }
      in_card=0
    }
  ' "$ROOT/index.html" 2>/dev/null | grep -oE '<p class="status">[^<]*</p>' | head -1)

  echo "--- $course ---"
  echo "  actual lesson files on disk:     $actual_lessons"
  echo "  objectives.html unique hrefs:    $obj_hrefs   (total planned entries: $obj_lesson_count, dangling/404 links: $dangling_links)"
  echo "  course index.html <li> links:    $idx_li_count"
  echo "  course index.html status line:   ${idx_status:-<none found>}"
  echo "  site homepage card status line:  ${home_status:-<no card found for this course>}"

  # PRECISE check: any href in objectives.html pointing to a file that doesn't
  # exist is a real bug (a live 404 link), regardless of whether the raw counts
  # happen to match — this is the check that would have caught vault/docker's
  # objectives.html shipping with all-real hrefs before any lesson existed.
  if [ "$dangling_links" != "0" ]; then
    echo "  MISMATCH: objectives.html links $dangling_links lesson(s) that don't exist on disk yet — these should be href: null with a 'planned' tag until the file is actually written"
    FAIL=1
  fi
  if [ "$idx_li_count" != "MISSING" ] && [ "$actual_lessons" != "$idx_li_count" ]; then
    echo "  MISMATCH: $actual_lessons files on disk but course index.html lists $idx_li_count lesson links"
    FAIL=1
  fi
  if echo "$idx_status" | grep -qi "complete" && [ "$actual_lessons" = "0" ]; then
    echo "  MISMATCH: index.html claims complete/done but 0 lesson files exist on disk"
    FAIL=1
  fi
  echo ""
}

if [ "${1:-}" = "--all" ]; then
  for d in "$ROOT"/*/; do
    slug=$(basename "$d")
    [ -d "$d/lessons" ] && check_one "$slug"
  done
else
  if [ -z "${1:-}" ]; then
    echo "Usage: $0 <course-slug> | --all"
    exit 2
  fi
  check_one "$1"
fi

if [ "$FAIL" = "1" ]; then
  echo "FAIL — at least one mismatch found above. Fix before claiming this course is done/published."
  exit 1
else
  echo "OK — no cross-file mismatches found."
  exit 0
fi
