# Agent Spec Template (`agent-design/<name>/spec.md`)

The spec is the single source of truth: change the spec first, then the artifact. Every entry must be traceable to something the user said or a default they were explicitly told about; mark anything unconfirmed as "default" or "to be confirmed".

```markdown
# Agent Spec: <display name> (<short English name>)

Version: v0.1　Mode: A personal need / B product goal　Updated: YYYY-MM-DD

## 1. One-sentence positioning
For [who], in [what scenario], to [do what task], delivering [what result].

## 2. Goal and success criteria
- Problem to solve:
- Success criteria (observable): e.g. "Of 10 weekly-report drafts, ≥ 8 need fewer than 3 edits from the user"
- Mode B: linked product metrics (north-star / process metrics):

## 3. Users and scenarios
- Users: (Mode B: link persona cards at user-research/<product>/personas/…)
- Trigger scenario / entry point:
- Frequency of use:

## 4. Core tasks (first version, ≤ 3)
| Task | Input | Processing key points | Output | Example (link to tests/cases.md) |
|---|---|---|---|---|

## 5. Inputs and outputs
- Input form:
- Output format (structure, length, language):
- Where the output goes: used directly / draft / written to file / calls a system

## 6. Tools and data
| Tool / data | Purpose | Permission (read-only / writable / needs confirmation) | Source |
|---|---|---|---|

## 7. Knowledge and context
- Rules, templates, and terminology that must be followed:
- Location of reference materials:
- Priority of information sources when unsure:

## 8. Boundaries and permissions
- Prohibited:
- Must get consent before executing:
- When out of scope: (refuse / hand off to a human / suggest another tool)

## 9. Style and persona
- Tone and form of address:
- Level of detail:
- Proactivity: (only does what is asked / proactively flags risks / proactively asks follow-up questions)
- Style sample: (the exact text of the sample the user chose)

## 10. Failure handling
- Insufficient information:
- Tool errors:
- Uncertain answers:

## 11. Artifact form
- Form: subagent / Skill / system prompt / SDK code / platform config
- Location:
- Model: (by default chosen by task difficulty; see output-formats.md)

## 12. Future iterations (not in the first version)
-

## 13. Decision log
| Date | Decision | Basis (the user's own words or the reasoning) |
|---|---|---|
```

## Checklist for writing the spec

- [ ] The one-sentence positioning contains no words like "all-purpose" or "various"
- [ ] The success criteria can be judged by test cases
- [ ] Every tool has a reason to exist, and every writable permission has a record of user confirmation
- [ ] All irreversible / external actions are listed under "Must get consent before executing"
- [ ] There is at least 1 real example provided by the user
- [ ] Mode B: has compliance no-go areas and conditions for handing off to a human
