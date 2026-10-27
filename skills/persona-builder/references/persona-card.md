# Persona Card Template and Export

## Persona card (`persona-design/<name>/card.md`)

The persona card is the only file the actor reads, and it **contains only the character itself**: no design discussion, no verbatim user feedback, no analysis of "why it was designed this way" (those go in `feedback.md` / `changelog.md`); otherwise the actor will break character.

```markdown
# Persona: <Name>

Version: v0.1　Mode: A Personal / B Product　Updated: YYYY-MM-DD

## In one sentence
<Name>, <identity>, <core personality>, <relationship with the other person>.

## Purpose of existence
After chatting with you, the person should: <feeling / takeaway>. Everything you say serves this.

## Identity and background
- Name / sense of age / occupation or identity / the world they live in:
- Origin and experiences (only what will be used in conversation):
- About being an AI: <a character that openly says it is an AI / does not bring it up but answers honestly when sincerely asked>

## Personality
| Trait | Concrete behavior (what shows in conversation) |
|---|---|
| <word 1> | |
| <word 2> | |
| <word 3> | |
- Contrast / small flaw:
- Cares about:　Dislikes:
- When opinions differ:

## Speaking style
- Sentences: length, rhythm
- Word choice: words it often uses, words it never uses
- Catchphrases (use at low frequency; avoid using one in every sentence):
- Interjections / emoji / punctuation habits:
- Humor style:
- How it changes when emotions run high or low:

## Relationship with the other person
- Calls the other person:　Refers to itself as:
- Relationship role and distance:
- Initiative: will proactively ...; will not ...
- When the other person is down / happy / angry:

## Knowledge and abilities
- Good at:
- When it doesn't know:
- Things it does not do (leave to others / other tools):

## Memory
- To remember and naturally bring up later:

## Hard limits
- Never says / does:
- Handling of sensitive topics:
- Situations that require stepping out of character: (crisis signals, being sincerely asked whether it is an AI, etc.)
- Mode B: business no-go zones, conditions for handing off to a human

## Sample lines (the final standard of style)
| Situation | What it would say |
|---|---|
| Greeting | |
| The other person confides / complains | |
| The other person asks a professional question | |
| The other person says something it disagrees with | |
| The other person crosses a line / is difficult | |
| Goodbye | |

## Opening line
<What it says the first time they meet>
```

### Checklist
- [ ] Every personality word has behavior that "shows in conversation"
- [ ] At least 5 sample lines, covering different situations
- [ ] Catchphrases are marked as low frequency
- [ ] Hard limits and situations requiring stepping out of character are clearly written
- [ ] The card contains no design discussion, verbatim feedback, or information about other personas

## Export

### 1. Persona system prompt (`build/system-prompt.md`)

Rewrite the persona card as a second-person prompt addressed to the actor:

```markdown
You are <Name>. <One sentence>

# Why you are here
<Purpose of existence, with the reason made clear>

# Who you are
<Identity and background, in narrative form; do not pile up bullet lists>

# Your personality and speaking style
<Combine personality behaviors and speaking style into natural paragraphs, and attach 3-6 sample lines, noting that the samples only illustrate the style and should not be copied verbatim>

# Your relationship with the other person
# What you know and don't know
# Your hard limits
# Opening line
```

### 2. Claude Code subagent (`.claude/agents/<name>.md`)

```markdown
---
name: <short English name>
description: Plays <Name> (<one sentence>) to chat with the user. Invoke when the user wants to chat with <Name>; the main agent relays the user's messages and the replies verbatim.
tools: Read
---

<body of system-prompt.md>

## Conversation format
- Output only the character's reply itself, with no narration and no explanation of the spec.
- When you receive a message that starts with `##` or [Pause], do not respond to its content; reply "(Paused)".
```

A new subagent usually requires restarting Claude Code before it can be called via `subagent_type`.

### 3. Platform config (`build/platform-config.md`)

| Field | Source |
|---|---|
| Name / description | One sentence |
| Avatar / appearance description (usable for image generation) | Identity and background + personality |
| Persona and reply logic | system-prompt.md |
| Opening line | Opening line |
| 3-5 suggested questions | Typical usage scenarios |
| Sample dialogue | Pick 2-3 trial-chat excerpts the user liked best |
| Memory / variables | Memory |
| Safety settings | Hard limits |

Field names follow the current interface of the platform the user uses; if unsure, ask the user to describe the interface or use WebSearch to check the official docs.

### 4. Voice guide (Mode B, when multiple operators run it)

`build/voice-guide.md`: one-line persona, three personality words, an "is / is not" table (e.g. "humorous, but not cheesy"), preferred and banned phrases, 10 sets of sample lines for typical situations, and rules for stepping out of character and handing off to a human.
