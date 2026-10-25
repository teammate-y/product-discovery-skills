# Product Discovery Skills for Claude Code

A set of four Claude Code skills and two subagents that take you from **"we have a vague product idea"** to **"we know the market, we know our users, and we have working AI agents and characters to build with."**

| Piece | Type | What it does |
|---|---|---|
| [`product-research`](.claude/skills/product-research/SKILL.md) | Skill | Market sizing, competitor analysis, North Star metric breakdown, Wei-Zhu business model analysis, product essence, channel analysis → a structured research report |
| [`user-communication`](.claude/skills/user-communication/SKILL.md) | Skill | Target user segments, personas, tag system, interview guides, surveys, talk tracks, **simulated interviews**, and insight synthesis |
| [`persona-builder`](.claude/skills/persona-builder/SKILL.md) | Skill | Design an AI character (brand IP, companion, practice partner, game NPC) by *chatting with it* and tuning it until it feels right |
| [`agent-builder`](.claude/skills/agent-builder/SKILL.md) | Skill | Interview you, write an agent spec, generate the agent (subagent / skill / system prompt / SDK code / Coze·Dify·GPTs config), trial-run it, iterate |
| [`persona-user`](.claude/agents/persona-user.md) | Subagent | Plays one target user from a persona card. Used by `user-communication` for interviews and live chats |
| [`persona-actor`](.claude/agents/persona-actor.md) | Subagent | Plays one AI character from a persona card, in an isolated context. Used by `persona-builder` |

## How the pieces fit together

```
 product-research ───► user-communication ───► agent-builder ◄─── persona-builder
 (market, business       (personas, interviews,  (spec → build →     (AI character
  model, channels,        insights)               test → iterate)     design)
  metrics)                      │                       │                  │
                                ▼                       ▼                  ▼
                           persona-user ◄───────────────┘            persona-actor
                     (plays a target user:                        (plays the character
                      interviews, live chats,                      in an isolated
                      agent trial runs)                            conversation)
```

Each skill works on its own, and they also chain together:

- The **Open Questions to Verify** section of a `product-research` report becomes the hypothesis list that `user-communication` validates.
- Persona cards from `user-communication` (`user-research/<product>/personas/`) describe the end users for `agent-builder` and `persona-builder`, and `agent-builder` can trial-run a conversational agent against them through `persona-user`.
- In product mode, `agent-builder` and `persona-builder` first read any existing `product-research/` and `user-research/` folders and skip questions that are already answered.
- When a character from `persona-builder` needs real task abilities or code integration, it hands off to `agent-builder`.

## Design principles

- **You are the source of requirements.** The skills interview *you* and never fill in key decisions (permissions, goals, trade-offs) on your behalf. Simulated users are for rehearsal and hypothesis generation, not for deciding what to build.
- **Examples beat adjectives.** Personas are tuned with sample lines; agents are built from one real input → expected output pair.
- **Isolated contexts.** Each simulated user runs in its own subagent, so personas don't leak into each other. Characters can also run in an isolated subagent, so the designer's intent doesn't color the role-play.
- **Testable means trustworthy.** An agent isn't "delivered" until it has test cases and a trial-run record.
- **Everything lands in files.** Persona cards, specs, transcripts, and changelogs are saved so you can resume and iterate later.

## Install

Skills and subagents are plain Markdown. Copy them into a Claude Code project or your user directory:

```bash
git clone https://github.com/<your-username>/product-discovery-skills.git
cd product-discovery-skills

# Per project
mkdir -p /path/to/your/project/.claude/{skills,agents}
cp -R .claude/skills/* /path/to/your/project/.claude/skills/
cp -R .claude/agents/* /path/to/your/project/.claude/agents/

# Or globally (available in every project)
mkdir -p ~/.claude/{skills,agents}
cp -R .claude/skills/* ~/.claude/skills/
cp -R .claude/agents/* ~/.claude/agents/
```

Restart Claude Code. The skills trigger automatically from natural language (see each skill's `description`), or you can invoke one directly, e.g. `/product-research`.

> **Install all of it together.** `user-communication` and `agent-builder` use the `persona-user` subagent, and `persona-builder` uses `persona-actor` for isolated conversations.

## Demos

> The transcripts below are **illustrative**, shortened examples of the interaction style each skill is designed to produce. They are not recorded runs. Your outputs will differ.

### 1. `product-research` → a research report

```
You:    Run product research on an AI meal-planning app for busy parents in the US.

Claude: Before I start, three things I'll assume unless you correct me:
        • Purpose: go/no-go for a seed-stage product   • Geography: US, last 3 years
        • Depth: full report
        I'll cite sources and dates for every number and flag anything I had to estimate.
        ...
```

The report it writes follows a fixed structure:

```markdown
# AI Meal-Planning App Research Report
## 1. Core Conclusions (One-Pager)       ← verdict, 3 reasons, 3 biggest risks, next steps
## 2. Business Understanding and Key Assumptions
## 3. Market Research                    ← TAM/SAM/SOM, trend, PEST, "why now"
## 4. Competitive Analysis               ← comparison table, Five Forces, SWOT, moat
## 5. Metric Breakdown                   ← North Star → metric tree → unit economics
## 6. Business Model (Wei-Zhu Six Elements)
## 7. Product Research                   ← needs, user groups, history, differentiation, essence
## 8. Market Channels
## 9. Open Questions to Verify           ← feeds directly into user-communication
## Appendix: Data Sources
```

Tip: save the report under `product-research/` in your project so `agent-builder` and `persona-builder` can pick it up later.

### 2. `user-communication` → personas and simulated interviews

```
You:    Build personas for the meal-planning app and interview them.

Claude: I've identified 4 user segments. Priority: P01 "Overloaded dual-income parent",
        P02 "Budget-first single parent" ... Persona cards saved to
        user-research/meal-app/personas/.
        I'll launch one isolated persona-user subagent per persona so their answers
        don't influence each other. Interview guide follows The Mom Test:
        past behavior, not hypotheticals.

P01 (simulated):  Honestly? Sunday night I open three tabs of recipes, get
                  overwhelmed, and we order pizza. I don't need more recipes.
                  I need someone to just decide.

Claude: Insight (simulated, needs real-user validation): the pain is decision
        fatigue, not recipe discovery. Added to the hypotheses list in report.md.
```

You can also **talk to a persona yourself** to practice interviewing or test a script, using control commands:

```
You:    [Pause]
Claude: (stepping out) That last question was leading. Try "Tell me about the
        last time you planned dinners for the week." Want to retry it?
You:    [Redo]
```

Commands: `[Pause]` / `##…` (talk to your coach), `[Resume]`, `[Redo]` (take back your last question and rephrase it), `[Switch to P0X]`, `[Ask everyone]`, `[End]`. Live conversations are saved to `interviews/` and labeled as simulated.

### 3. `persona-builder` → a character you tune by chatting

```
You:    I want a study buddy who nudges me to keep going, a bit sarcastic.

Claude: Which of these sounds most like them?
        A) "Ten minutes. That's all I'm asking. Then you can go back to
            pretending the exam doesn't exist."
        B) "Look at you, opening the textbook. Should I alert the press?"
        C) "Cute plan. Now do the first problem."

You:    B, but a little warmer.

Claude: Persona sketch — "Mo", a deadpan upperclassman who teases because
        they care. Calls you by name, never mocks your actual mistakes,
        hard limit: never joke about your anxiety. Ready to try a chat?

Mo:     Oh, you showed up. And with a textbook. Who are you and what
        did you do with my friend?

You:    [Pause]
        ## less sarcastic at the start, I'm tired today
Claude: Noted. Updating the card: sarcasm ramps up with the user's energy.
```

Other commands: `[Continue]`, `[Redo]` (re-say the last line with the updated persona), `[Switch scene ...]`, `[End]`. By default Claude plays the character itself; for an isolated conversation it launches `persona-actor` and relays messages verbatim.

Export: a reusable system prompt, a Claude Code subagent, or a Coze / Dify / GPTs configuration, saved under `persona-design/<name>/`.

### 4. `agent-builder` → spec, build, test, iterate

```
You:    I want an agent that turns my meeting notes into action items.

Claude: Understood: for you, after meetings, to turn raw notes into an owner +
        deadline + next-step list. Quick questions (recommended option first):
        1. Output where? ● A markdown file (recommended)  ○ Email draft  ○ Notion
        2. May it send anything on your behalf? ● No, draft only (recommended)
        3. Paste one real set of notes and the list you'd want from it.
        ...
        Spec saved to agent-design/meeting-actions/spec.md.
        Plan: a Claude Code subagent. I'll generate it, then run 8 test cases
        (including "no clear owner" and "notes are mostly small talk").

Round 1:  6/8 passed. Failed: invents deadlines when none are stated.
Fix:      "Never invent a date; write 'TBD' and ask." Logged in changelog.md.
Round 2:  8/8 passed. Delivered with known limitations and a v2 list.
```

Generated layout:

```
agent-design/meeting-actions/
├── spec.md          # single source of truth
├── build/           # generated agent
├── tests/cases.md
├── tests/runs/round-01.md …
└── changelog.md
```

## Repository layout

```
.claude/
├── agents/
│   ├── persona-actor.md
│   └── persona-user.md
└── skills/
    ├── agent-builder/       (SKILL.md + references/)
    ├── persona-builder/     (SKILL.md + references/)
    ├── product-research/    (SKILL.md + references/)
    └── user-communication/  (SKILL.md + references/)
```

## Notes

- `product-research` uses WebSearch / WebFetch for public data when available, and tells you which numbers are sourced, estimated, or assumed.
- Simulated interviews are a way to sharpen hypotheses and rehearse. They do **not** replace talking to real users, and the skills label insights as *simulated* vs. *real*.
- `persona-builder` will not build a persona that claims to be a real living person, and in product mode the persona answers honestly when a user sincerely asks whether it is an AI.
- Control strings (`[Pause]`, `##`, `Mode: chat`) are shared between the skills and the subagents. If you rename one, rename it on both sides.
- The skills and subagents need no extra dependencies, just Claude Code.

## License

See [LICENSE](LICENSE).
