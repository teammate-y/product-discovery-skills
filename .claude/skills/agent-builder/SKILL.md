---
name: agent-builder
description: Custom AI agent building. Through multi-round conversation with the user themselves, turns a personal need or product goal into an Agent spec (goal, users, tasks, inputs/outputs, tools, knowledge, boundaries, style, success criteria), then generates a ready-to-use agent (Claude Code subagent / Skill / system prompt / Agent SDK code / platform configs for Coze, Dify, GPTs, etc.), runs it against test cases, and iterates with the user until they are satisfied. Use when the user mentions "custom agent", "build an AI assistant", "write an agent / bot for me", "write a system prompt", "make a subagent", "hand this workflow to AI", or "we need an AI assistant inside our product".
---

# Custom AI Agent Building (Agent Builder)

Goal: talk with **the user themselves** and turn a vague request like "I want an AI that helps me with XX" into an agent that is **well-bounded, testable, and ready to use**, then tune it with the user through trial runs until they are satisfied.

How this connects to other skills:
- `product-research`: product goals, user groups, and north-star metrics feed this skill's "goal" and "success criteria".
- `user-communication`: persona cards feed this skill's "end users"; in step 5, a `persona-user` subagent can play the end user to try out the agent you built.

## Two modes (decide first)

| Mode | Signals | Who the agent serves | Conversation focus |
|---|---|---|---|
| A. Personal need | "Help me…", "Every day I have to…", "my workflow" | The user themselves | The user's real workflow, how they do it now, which step is most annoying, how much autonomy they want |
| B. Product goal | "We need a … in our product", "an assistant for customers", "smart customer service" | The product's end users | Product goals and metrics, who the end users are, brand tone, compliance and risk, launch channel |

If you can't tell, just ask one question. In Mode B, if output already exists in `product-research/` or `user-research/`, read it first and **don't re-ask what's already been concluded**.

## Workflow

### 1. Opening: one-sentence restatement + key gaps

First infer as much as you can from what the user said, then restate it in one sentence:

> I understand you want an agent for **[who will use it]**, in **[what scenario]**, to help **[do what task]**, ultimately delivering **[what result]**. Is that right?

Then list the 2–3 gaps you most need confirmed. **Don't ask about what you can infer or what has a sensible default** (write defaults into the spec and let the user see them in your restatement).

### 2. Requirements interview (with the user themselves, multiple rounds, ≤ 3–5 questions per round)

Work through the 9 dimensions in `references/interview.md`, in this priority order:

1. **Goal and success criteria**: After using this agent, what gets better? How will you tell it did a good job?
2. **Users and scenarios**: Who uses it, when, and through what entry point?
3. **Core tasks**: The 3 things it will do most often; **one real example** (ask the user to paste a real input and the output they'd want for it. This is the most valuable information)
4. **Inputs / outputs**: What it receives (text, files, links, spreadsheets) and what it hands back (format, length, where it lands)
5. **Tools and data**: What it needs to read and write (files, web pages, databases, APIs, MCP), and which are read-only
6. **Knowledge and context**: Domain knowledge, rules, terminology, and sources it needs to know
7. **Boundaries and permissions**: What it must never do; which actions require asking a person first (sending, deleting, paying, publishing externally)
8. **Style and persona**: Tone, language, level of detail, whether it should proactively ask follow-up questions
9. **Failure handling**: What to do when information is insufficient, the task is beyond its ability, or something goes wrong

How to run the conversation (mandatory):
- **Use options instead of open-ended questions**: where you can offer options, use AskUserQuestion, put your recommended option first and mark it "(recommended)".
- **Ask for examples, not adjectives**: for "make it more professional", ask the user for a sample answer they consider "professional", or write two versions for them to pick from.
- **Ask about what they actually did in the past**: "How did you do this by hand last time? Where did you get stuck?" is more reliable than "How do you want it to do this?"
- **Proactively point out risks and trade-offs**: when the user wants too much autonomy, goals conflict, or the tasks are too scattered, say so directly and offer a suggestion (for example, split it into two agents).
- **Control scope**: the first version covers only the 1–3 most essential tasks; log everything else under "Future iterations".
- At the end of each round, summarize "confirmed / to be confirmed" in 2–4 lines so the user can correct you at any time.

Once the information is mostly in place (the first 7 of the 9 dimensions have answers or clear defaults), move on to the next step. Don't keep asking indefinitely.

### 3. Write the agent spec → restate in plain language → user confirms

Write the spec following `references/agent-spec.md` and save it to:

```
agent-design/<agent short English name>/
├── spec.md          # Agent spec (single source of truth)
├── build/           # Generated agent artifacts
├── tests/cases.md   # Test cases
├── tests/runs/      # Record of each trial-run round: round-01.md …
└── changelog.md     # What changed in each iteration and why
```

Restate it to the user in plain language (don't dump the whole spec on them). Template:

> This agent is called **X**, for **[who]**, and mainly does 3 things: ① … ② … ③ ….
> Tools it can use: … (read-only: …); **it will always ask you first before sending, deleting, or doing anything external**.
> It will not: …. When information is insufficient, it will: ….
> The standard for judging it did well: ….
> I plan to build it as **[artifact form]**, placed at **[location]**. If you confirm, I'll generate it and trial-run it with your examples.

Generate only after the user confirms. Any permission the user hasn't confirmed is treated as least privilege.

### 4. Choose the artifact form and generate

Choose based on where the user will run it; details and templates are in `references/output-formats.md`:

| Where the user will use it | Artifact | Location |
|---|---|---|
| Called by the main agent inside Claude Code, needs isolated context | Subagent | `.claude/agents/<name>.md` (project) or `~/.claude/agents/` (global) |
| A reusable process/method inside Claude Code | Skill | `.claude/skills/<name>/SKILL.md` |
| Their own program / product backend | System prompt + Agent SDK / Messages API code | `build/` (before writing code, load the `claude-api` skill to get the latest usage and model IDs) |
| Coze / Dify / GPTs / other platforms | Platform config checklist (persona and reply logic, knowledge base, plugins/tools, opening message, example questions) | `build/platform-config.md` |
| Just a prompt | System prompt | `build/system-prompt.md` |

When writing prompts, follow `references/prompt-patterns.md`: explain goals and reasons instead of piling on rules, give real examples, state boundaries and escalation conditions clearly, and define the output format.

### 5. Trial run and evaluation

Follow `references/evaluation.md`:

1. **Write test cases** (`tests/cases.md`): real examples from the user come first, then add typical cases, edge cases, and cases where it should refuse or ask first, 5–10 in total; for each, state the "expected behavior" and "pass criteria". **Have the user look them over and add to them.**
2. **Trial run**: for each case, launch a **separate** `general-purpose` subagent (launch them in parallel in a single message). The prompt contains only: the path to the generated agent's prompt file (tell it to read the file first and follow it strictly) + that case's input. Do not pass in the spec, expected answers, or your evaluation criteria.
   - For conversational agents in Mode B: you can have a `persona-user` subagent play the end user (the persona comes from `user-communication`), with you relaying messages between the two, for 3–6 rounds of conversation.
3. **Evaluate**: grade each criterion ✅ / ⚠️ / ❌ and record it in `tests/runs/round-XX.md`.
4. **Show the user**: pick the 2–3 most representative raw outputs plus a summary of the problems, and **ask the user how it feels** ("Would you use this answer as is? What needs to change?"). The user's judgment takes priority over yours.

### 6. Iterate

- Revise the prompt / tools / spec based on failed cases and user feedback, and log every change in `changelog.md` (what changed, why, and which case it relates to).
- After each change, **rerun all cases** to avoid fixing one thing and breaking another.
- It usually converges in 2–3 rounds; deliver when the user says "good enough" or all key cases pass.

### 7. Deliver

Tell the user:
- Where the artifact is and how to enable it (for example: "After restarting Claude Code, say 'use the X agent to handle…' to call it"; or how to run the API code)
- What it can and can't do, and in which situations it will stop and ask a person
- A summary of test results (how many passed, known limitations)
- The list of future iterations (requirements the first version didn't cover)
- How to give feedback and adjust: invoke this skill again and point it at `agent-design/<name>/`, and it will iterate on the existing spec

## Principles

- **The user themselves is the only source of requirements**: don't fill in key decisions (permissions, external behavior, goal trade-offs) on the user's behalf; simulated users are for trial runs only, never for deciding requirements.
- **Examples beat descriptions**: get at least one real input → expected output example before writing the prompt.
- **Least privilege**: give only the tools needed to complete the task; irreversible, external, or money-spending actions default to "ask a person first".
- **Small and clear beats big and all-encompassing**: one agent, one clear responsibility; split it up if the needs are too scattered.
- **Testable means trustworthy**: an agent without test cases is not considered delivered.
- **The spec is the single source of truth**: change the spec first, then the artifact.
