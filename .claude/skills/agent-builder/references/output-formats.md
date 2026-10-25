# Artifact Forms and Templates

All artifacts are written to `agent-design/<name>/build/` first, and copied to where they actually take effect (such as `.claude/agents/`) after the user confirms. Before overwriting an existing file, look at it and tell the user.

## 1. Claude Code subagent

Suited for: dedicated tasks delegated by the main agent that need independent context and restricted tools (review, retrieval, drafting, role simulation).

Location: `.claude/agents/<name>.md` (project level) or `~/.claude/agents/<name>.md` (global). After adding one, you usually need to restart Claude Code or check in `/agents` to confirm it took effect.

```markdown
---
name: <short English name, lowercase-hyphenated>
description: <When it should be invoked. State the trigger scenarios and responsibility boundaries clearly; the main agent relies on this text to decide whether to delegate.>
tools: Read, Grep, Glob        # List only the necessary tools; if omitted, inherits all tools
model: sonnet                  # Optional: sonnet / opus / haiku / inherit
---

You are <role>, responsible for <responsibility>.

## Goal
<What to achieve and why it matters>

## How to work
1. …
2. …

## Boundaries
- Do not: …
- When you run into …, stop and say so in your result, and let the main agent decide

## Output format
<What the main agent needs to receive: structure, fields, length>
```

Key points: a subagent cannot see the main conversation, so **the caller must pass the input in the prompt**; the output is for the main agent to read, so keep it structured and concise.

## 2. Claude Code Skill

Suited for: a reusable method/process that runs in the main conversation, may need to interact with the user, and may come with reference files or scripts.

Location: `.claude/skills/<name>/SKILL.md`, optionally with `references/`, `scripts/`, `assets/`.

```markdown
---
name: <short English name>
description: <What it does + when to use it + trigger phrases>
---

# <Name>

Goal: …

## Workflow
### 1. …
### 2. …

## Output format
## Principles
```

Key points: the description determines whether the skill gets triggered, so include keywords users will say; keep the body concise and put details in references to be read on demand.

## 3. System prompt (generic)

Suited for: anywhere that supports a system prompt. Write it to `build/system-prompt.md` with this structure:

```markdown
# Role and goal
# Users and scenarios
# What you do (one section per task, each with: input, approach, output)
# Tool use (when to use, when not to)
# Boundaries and actions needing confirmation
# Style
# When information is insufficient / something errors
# Examples (1–3 real inputs → ideal outputs)
```

## 4. Agent SDK / Messages API code

Suited for: when the user wants to plug the agent into their own program or product.

- **Load the `claude-api` skill before writing code**, and follow its latest SDK usage, model IDs, tool-calling, and caching patterns rather than writing from memory.
- Choosing: only conversation + a few custom tools → Messages API + tool-use loop; need full agent capabilities such as files/commands/MCP → Claude Agent SDK.
- Choose the model by task by default: use the strongest model for complex reasoning/long tasks and a faster, cheaper model for frequent simple tasks; write the reasoning for the choice into the spec.
- Deliverables: `build/system-prompt.md` + minimal runnable code + `build/README.md` (installation, environment variables, running, how to change the prompt). Read keys only from environment variables.

## 5. Third-party platform configuration (Coze / Dify / GPTs / enterprise IM bots, etc.)

Write to `build/platform-config.md`, organized by the fields commonly found on platforms, so the user can copy and paste:

| Field | Content source |
|---|---|
| Name / description / avatar description | Spec §1 |
| Persona and reply logic (system prompt) | Section 3 template |
| Opening message + 3–5 example questions | Core tasks |
| Knowledge base (which materials to upload, how to chunk) | Spec §7 |
| Plugins / tools / workflow nodes | Spec §6 |
| Variables / memory | Information that must be remembered across turns |
| Safety settings (sensitive words, handoff to a human) | Spec §8 |

Field names follow the current interface of the platform the user is using; when unsure, ask the user for a screenshot or a description of the interface, and use WebSearch to check the official docs if needed.

## Selection guide

| Situation | Recommendation |
|---|---|
| Needs multi-round confirmation with the user and a step-by-step process | Skill |
| One-off dedicated task, need to protect the main conversation's context | Subagent |
| Need both | Skill orchestrates the process + calls a subagent to execute (e.g. user-communication + persona-user) |
| Faces the product's end users | System prompt + SDK/platform |
