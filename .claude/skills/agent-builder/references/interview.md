# Requirements Interview (with the user themselves)

Goal: get the information needed to write the spec in as few rounds as possible. **Don't ask about what you can infer or what has a default**, ask 3–5 questions per round, and offer options first.

## The 9 dimensions and question bank

| # | Dimension | What must be clarified | Suggested phrasing | Default (if the user has no opinion) |
|---|---|---|---|---|
| 1 | Goal and success criteria | What problem it solves; what "done well" looks like | "After you start using it, which one thing do you most want to change? Save time, improve quality, or avoid missing things?" "How will you tell it did a good job this time?" | — (must ask) |
| 2 | Users and scenarios | Who uses it, when, and from where | "Is it mainly for you, or for colleagues/customers?" "When would you usually think to use it?" | Mode A: the user themselves |
| 3 | Core tasks | The 1–3 most frequent things + a real example | "Can you paste a recent real example? What do you give it, and what do you want back?" | — (must ask) |
| 4 | Inputs/outputs | Input form; output format, length, destination | "Will you use the result directly (send it out / archive it), or as a draft to edit further?" | Markdown, concise, draft |
| 5 | Tools and data | Which files/sites/systems to read and write; read-only or writable | "Does it need to look things up on the web or read files by itself? Should it be allowed to modify files?" | Read-only, no internet |
| 6 | Knowledge and context | Domain rules, terminology, reference materials | "Are there rules, templates, or reference materials it must follow? Where are they?" | None |
| 7 | Boundaries and permissions | Prohibited things; actions needing human confirmation | "What must it absolutely never do? Should it ask you first before sending messages / deleting things / spending money?" | Irreversible/external actions always ask first |
| 8 | Style and persona | Tone, language, level of detail, proactivity | Give two versions of an answer for the user to pick from | English, direct, conclusion first and details after |
| 9 | Failure handling | When information is insufficient / beyond ability / something errors | "When the material isn't enough, do you want it to ask you first, or finish with reasonable assumptions and flag them?" | Ask first when key information is missing; otherwise flag assumptions |

Additional confirmations for Mode B (product goal):

| Dimension | How to ask |
|---|---|
| Product goals and metrics | "Which metric will you watch after this agent launches? Resolution rate, conversion rate, retention, human-replacement rate?" |
| End users | "Who will be using it? Do you have personas? How digitally literate are they?" |
| Brand and tone | "Is there a brand tone guideline? Can it refer to itself as 'I'? Can it joke around?" |
| Compliance and risk | "Is there anything it can't say (promising returns, medical/legal advice, commenting on competitors)? Should it hand off to a human?" |
| Launch channel | "Will it live inside an app, on the web, in WeChat, in enterprise IM, or behind an API?" |
| Cost and latency | "Is there a cap on cost per conversation and response time?" |

## Follow-up techniques

- **Restate your inference and let the user correct it**: "I understand it as ……, is that right? Mainly I want to confirm two things: ① …… ② ……"
- **Dig for needs in past behavior**: "How long did it take you to do this by hand last time? Which step was the most annoying?" The most annoying step is the agent's core value.
- **Turn adjectives into samples**: "You said 'make it professional'. I wrote versions A and B; which is closer?"
- **Turn "I want it all" into a ranking**: "If you could only do one first, which would it be?"
- **Spot hidden permission needs**: "After it's written, will you send it yourself, or do you want it to send it directly?"
- **When the user doesn't know, offer a recommendation**: don't push the decision back to the user; give a recommendation + reasons and let them approve or veto it.

## Situations where you should proactively warn the user

| Signal | Warning |
|---|---|
| Tasks span 4 or more unrelated domains | Suggest splitting into multiple agents, or one main agent + subagents |
| Wants fully autonomous execution of external/irreversible actions | Explain the risk and suggest a "draft + human confirmation" mode |
| Success criteria can't be judged | Help the user set an observable standard (e.g. "8 out of 10 usable as is") |
| Required data is unreachable (no API, login required) | State the limitation clearly and offer alternatives (the user pastes manually, exports a file) |
| Expects 100% accuracy (medical, legal, financial) | Explain that a human review step is needed and write it into the spec |

## Per-round summary template

> **Confirmed**: …; …
> **Handled by default** (speak up if you disagree): …
> **Still need you to decide**: ① … ② …

## Condition for ending the interview

Dimensions 1, 3, and 7 have clear answers, and the remaining dimensions have answers or the user has been told the defaults → move on to writing the spec.
