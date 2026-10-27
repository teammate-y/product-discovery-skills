#!/usr/bin/env bash
# Copy subagent bodies (frontmatter stripped) into the skills that use them, so each
# skill still works where the subagent isn't installed (npx skills, Codex).
# Run after editing anything in agents/.
set -euo pipefail
cd "$(dirname "$0")/.."

copy() { # <agent> <skill>
  local out="skills/$2/references/$1-role.md"
  {
    echo "<!-- Generated from agents/$1.md by scripts/sync-roles.sh. Do not edit here. -->"
    awk 'BEGIN{n=0} n>=2{print; next} /^---$/{n++}' "agents/$1.md"
  } > "$out"
  echo "wrote $out"
}

copy persona-user user-communication
copy persona-user agent-builder
copy persona-user persona-builder
copy persona-actor persona-builder

if [[ "${1:-}" == "--check" ]]; then
  git diff --exit-code -- 'skills/*/references/*-role.md'
fi
