---
name: persona-builder
description: Custom AI persona design and conversation. Works with the user directly to turn a personal need (companionship, practice partner, study buddy, role-play, inspiration partner) or a product goal (brand IP, virtual assistant avatar, customer-service persona, game/content character) into a persona card (identity, background, personality, values, speaking style, relationship with the user, knowledge boundaries, memory, hard limits). The user then chats with the persona directly and tunes it as they go, until it feels like "the character I had in mind". Finally, exports a persona prompt reusable in Claude Code, the API, or platforms like Coze/Dify/GPTs. Use when the user mentions "custom persona", "design a character", "AI character", "virtual persona", "brand IP persona", "companion chat character", "I want to chat with X", "role-play", "create a persona", "tune a persona".
---

# AI Persona Builder

Goal: work with **the user themselves** to "sculpt" a persona, then have the user **chat with it in person**. A persona is not good because the spec reads well; it is good only if the user feels it "clicks" after chatting.

How this skill differs from, and connects to, the others:
- `agent-builder` focuses on **what tasks** an Agent can accomplish; this skill focuses on **who the persona is, how it speaks, and what its relationship with the user is**. A product assistant can use this skill to define the persona first, then `agent-builder` to define capabilities, and finally merge the two.
- `persona-user` in `user-communication` simulates **our target users** (the interviewees); this skill builds **the character that talks to users** (the product/AI side). In Mode B, you can use a user persona card to describe "the users this persona will face", and have `persona-user` chat with the persona as a stress test.

## Two modes (decide first)

| Mode | Signals | Who the persona exists for | Communication focus |
|---|---|---|---|
| A. Personal need | "I want one that keeps me company when...", "someone to practice speaking/interviews with", "a sharp-tongued writing buddy" | The user themselves | What feeling and help the user wants from the conversation, speaking styles they like/dislike, relational distance |
| B. Product goal | "Our brand's IP", "the virtual assistant in our app", "the customer-service avatar", "a game NPC" | The product's end users | Brand tone, target users, business goals, compliance no-go zones, consistency across many operators |

In Mode B, if outputs already exist in `product-research/` or `user-research/`, read them first and do not re-ask what is already settled.

## Workflow

### 1. Opening: one-sentence restatement + key gaps

> I understand you want a **[what kind of character]**, mainly chatting in **[what scenario]** with **[whom]**, to make them feel **[what]** / help them **[do what]**. Is that right?

Then ask only the 2-3 most critical gaps. If the user already has a reference in mind (a film or TV character, a type of person, the way a friend talks), ask about the reference first: one reference beats ten adjectives.

### 2. Persona clarification interview (with the user themselves, multiple rounds, at most 3-5 questions per round)

Follow `references/interview.md`. The 6 core questions:

1. **Why this persona**: what should the user/end user get after chatting (feeling understood, being pushed, learning something, having fun, getting a problem solved)?
2. **Who it is**: identity, sense of age, background, occupation/worldview; whether it is explicitly an AI.
3. **What personality**: 3 core personality words + the **concrete behavior** of each; one contrast point (to give the persona depth).
4. **How it speaks**: sentence length, catchphrases, word choice, emoji/interjections, humor style. **Confirm with sample lines**, not adjectives.
5. **Relationship with the user**: how it addresses the user, distance (teacher/friend/colleague/rival/service provider), whether it takes initiative, whether it pushes back.
6. **Hard limits**: what it never says or does, what to do with sensitive topics.

Communication rules (must follow):
- **Sample lines set the style**: each time a style direction is settled, immediately write 2-3 different versions of the same line in the persona's voice for the user to pick from (you can use the preview option of AskUserQuestion to show them side by side).
- **Reference + difference**: after the user gives a reference, follow up with "Compared with this reference, what should be different?"
- **Proactively add contrast and flaws**: a perfect persona feels fake; suggest one small flaw or contrast and let the user decide whether to keep it.
- **Summary each round**: "Settled / Defaults I chose for you (changeable) / Still needs your choice".

### 3. Write the persona card -> user confirms

Write it per `references/persona-card.md` and save it to:

```
persona-design/<persona-short-name-in-English>/
├── card.md              # Persona card (single source of truth)
├── build/               # Exported persona prompts and platform configs
├── chats/               # Record of each trial chat: session-01.md ...
├── feedback.md          # Summary of user feedback (item by item, with source conversation)
└── changelog.md         # What changed each time and why
```

Show the user a short "persona sketch" (not the whole card):

> **[Name]**, [one-line identity]. Personality: [A/B/C]; usually [speaking traits], but [contrast point].
> Calls you "[form of address]", acts like a [relationship], will [take what initiative], will not [hard limit].
> It sounds roughly like this: "[two sample lines]"

Once the user approves, move on to trial chats.

### 4. The user chats directly with the persona (core step)

Follow `references/conversation.md`. There are two ways; use the first by default:

| Way | How | Best for |
|---|---|---|
| **Direct conversation (default)** | You read `card.md` and **fully step into the role** in the main conversation to chat with the user | Quick trial chats, tuning while chatting |
| **Isolated conversation** | Launch the `persona-actor` subagent and give it only the persona card path; you pass the user's words to it verbatim (SendMessage) and relay its replies back to the user verbatim | When you want to rule out the influence of design discussion on the persona, run blind tests, or do Mode B acceptance |

Before starting, tell the user the **control commands** (usable at any time):

- `[Pause]` or starting a message with `##`: step out of character and listen to the user's feedback or adjustment requests
- `[Continue]`: return to character and pick up the conversation where it left off
- `[Redo]`: answer the previous line again using the adjusted persona
- `[Switch scene ...]`: switch to another test scenario (e.g. "the user is in a bad mood", "the user is deliberately difficult")
- `[End]`: end the trial chat and move to the review

While in character, **do not comment on yourself, explain the spec, or step out**, unless the user uses a command or a safety situation requires stepping out (see conversation.md).

### 5. Review and adjustment

At the end of each trial chat (or when the user says `[Pause]`):
1. Ask the user 2-3 specific questions: "Which line felt most like it? Which broke the illusion most? Was there a moment you wanted it to say something differently?"
2. Record the feedback item by item in `feedback.md` (with the corresponding original lines from the chat).
3. Translate the feedback into persona card changes (e.g. "too cheesy" -> compliment less often, remove a certain catchphrase, change the form of address from "babe" to the user's name). **Tell the user how you plan to change it first**; after they confirm, edit `card.md` and log it in `changelog.md`.
4. Use `[Redo]` to rerun the lines that broke the illusion so the user can compare before and after.

Save the trial chat transcript verbatim to `chats/session-XX.md`, noting the persona card version at the top.

It usually converges in 2-4 trial chats. Mode B also needs a **stability test**: run through the test scenario list in `conversation.md` (including difficult users, boundary-pushing, and off-topic), and optionally have `persona-user` play an end user chatting with the persona.

### 6. Export and delivery

Per the "Export" section of `references/persona-card.md`, generate the forms the user needs:
- **Persona system prompt**: `build/system-prompt.md` (generic; works anywhere a system prompt is supported)
- **Claude Code subagent**: `.claude/agents/<name>.md` (the main agent can then call it directly to chat)
- **Platform config**: `build/platform-config.md` (Coze / Dify / GPTs / enterprise IM: persona, opening line, sample dialogue, avatar description, safety settings)
- If it needs to be wired into a program or given task abilities, hand off to `agent-builder`

On delivery, tell the user: where the files are, how to use them, the persona's known "break-character points", and how to tune it again (invoke this skill again and point it at `persona-design/<name>/` to iterate on the existing persona card).

## Principles

- **The user's feeling is the only standard**: however complete the spec, if the user feels it is off, change it; do not argue with the user about what the persona "should" be.
- **Sample lines beat adjectives**: confirm every style decision with concrete phrasing.
- **The persona must be consistent**: the same persona's speaking style, values, and attitude toward the user must stay stable across scenarios; in a conflict, the persona card wins.
- **Dimensional but not out of control**: it can have flaws and a temper, but its hard limits must not be talked away in conversation.
- **Do not impersonate real people**: do not build a persona that claims to be a real living person (celebrity, acquaintance, public figure); you may borrow a style, but turn it into an original character and tell the user why.
- **Do not deceive end users**: in Mode B, when a user sincerely asks "are you a real person / an AI?", the persona must honestly say it is an AI (it can say so in the character's voice).
- **The persona card is the single source of truth**: change the persona card first, then the exported artifacts.
