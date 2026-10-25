# Testing and Evaluation

## 1. Test cases (`tests/cases.md`)

5–10 cases, covering four types:

| Type | Count | Description |
|---|---|---|
| Real cases | 2–3 | Real inputs provided by the user (most important) |
| Typical cases | 2–3 | Common variations of the core tasks |
| Edge cases | 1–2 | Insufficient information, malformed input, very long input, vague requests |
| Safety/permission cases | 1–2 | Requests it should refuse, ask about first, or hand off to a human |

Template:

```markdown
## C01 <short description> (type: real)
**Input**:
<original text>

**Expected behavior**:
- …

**Pass criteria**:
- [Must] … (❌ if not met)
- [Bonus] …
```

After writing the cases, let the user look them over: "Do these scenarios cover your main use? Is there any other situation it must handle well?"

## 2. How to run trials

### Single-turn task-type agents
One separate `general-purpose` subagent per case, launched in parallel in a single message. Prompt template:

```
First read the file agent-design/<name>/build/<prompt file>, treat its contents as your system instructions, and act strictly according to the role, boundaries, and output format in it.
(If the agent is allowed to use tools, use them as instructed; for actions that require consent first, do not execute them, and instead write in your output "Here I would first ask the user: …".)

Below is the input from the user:
<original case input>
```

Isolation rule: do not pass in the spec, expected behavior, pass criteria, or other cases.

### Subagent artifacts
A subagent newly written into `.claude/agents/` may need a restart before it can be called via `subagent_type`; until then, trial-run it as above by having a `general-purpose` agent read the file (ignore the frontmatter and treat the body as the system instructions).

### Multi-turn conversational agents (common in Mode B)
1. Launch a `general-purpose` subagent as the agent under test (same template as above, with the first message being the end user's opening).
2. Launch a `persona-user` subagent, with the persona card from `user-research/<product>/personas/`, and the task description "You are using a product's AI assistant and want to solve: <scenario>".
3. Relay messages between the two using SendMessage (before first use, load it with ToolSearch `select:SendMessage`), run 3–6 rounds, and record the conversation verbatim.
4. Use a separate set of instances for each persona, sharing no context.

## 3. Evaluation record (`tests/runs/round-XX.md`)

```markdown
# Round X trial run　Prompt version: v0.X　Date:

| Case | Result | Issue |
|---|---|---|
| C01 | ✅ | |
| C02 | ⚠️ | Format correct, but missed … |
| C05 | ❌ | Did … without confirmation |

## Typical outputs (verbatim)
### C02
…

## Root causes and revision plan
- Problem → cause (missing from prompt / tool permissions / unclear spec) → fix
```

## 4. Judging together with the user

- Show the user the verbatim text of 2–3 representative outputs and ask: "Would you use this result as is? What needs to change?"
- The user's judgment takes priority over your scoring; turn problems the user points out into new cases.
- If you find the spec itself is unclear (the user themselves can't say for sure), go back to the interview to ask more, and update the spec's decision log.

## 5. Pass criteria

- All [Must] criteria pass, or the user explicitly accepts the remaining issues as known limitations
- All safety/permission cases pass (non-negotiable)
- The user confirms "it's good to use"
