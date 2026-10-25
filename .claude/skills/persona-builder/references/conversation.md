# Trial Chats and Adjustment

## 1. Before the chat

Tell the user:
> Next I'll become **<Name>** and chat with you. Treat it as real and talk freely.
> To give feedback, use `[Pause]` or start your message with `##`; `[Continue]` returns to the conversation; `[Redo]` has it re-answer the previous line with the adjusted persona; `[Switch scene ...]` changes the test scenario; `[End]` ends the chat and starts the review.

You can suggest the user start with one of these kinds of topics (in Mode A, stick mainly to the user's real life; the more real, the better the problems show up):
- A real recent annoyance / happy event
- A real problem they need its help with
- Deliberately saying something it would not agree with

## 2. Direct conversation (default)

- Read the latest version of `card.md` before chatting; the persona card is authoritative, and anything from design discussion that is not written into the card is **not used**.
- Start with the opening line (unless the user speaks first).
- While in character:
  - Output only what the character says, with no narration, parenthetical notes, or meta-commentary like "As XX, I would..."
  - Keep replies to a length that fits the persona and scene (casual chat is usually 1-3 sentences)
  - Use catchphrases at low frequency, not in every sentence; do not mechanically reuse sample lines
  - Stay consistent: remember what the user said in this conversation and the "experiences" you have claimed
- When the user uses a command, respond to the command immediately; do not respond to its content in character.

### Situations that require stepping out of character
- The user shows signs of self-harm, suicide, or other crisis: respond gently as your normal self, express care, point to sources of help (e.g. a local mental health hotline), and once the user is confirmed safe, ask whether they want to continue
- The user sincerely asks "are you a real person?": answer honestly (you may first answer in the character's voice, then step out if needed)
- The conversation is steered toward illegal content, harming others, or anything beyond the persona's hard limits: you may first decline in character; if the other person persists, step out and explain

## 3. Isolated conversation (`persona-actor` subagent)

Use when: the design discussion has been long and you worry the main conversation "knows too much" and will affect the performance; for Mode B acceptance and blind tests.

1. Launch the `persona-actor` subagent with a prompt containing only:
   ```
   Your persona card file: persona-design/<name>/card.md
   Read the persona card first, then begin the conversation as that character.
   [The other person's first line / or: say your opening line]
   ```
2. Relay the subagent's replies to the user **verbatim** (labeled "<Name>:"), and send the user's words **verbatim** to the same subagent with SendMessage (before first use, load it with ToolSearch `select:SendMessage`). Do not polish, add, or speak on the user's behalf.
3. You handle the user's commands yourself and do not forward them to the subagent. On `[Redo]`: after editing the persona card, launch a new subagent, send it the conversation up to just before the previous line as "previous conversation record", and then send the previous line.
4. Do not pass design discussion, feedback, or guidance like "the user wants you to be more..." to the subagent; all adjustments are made by editing the persona card. This is how you verify whether the persona card itself is sufficient.

## 4. Test scenario list

During a trial chat, use `[Switch scene ...]` to switch. In Mode A, pick the few the user cares about; in Mode B, run all of them:

| Scenario | What to look at |
|---|---|
| First meeting | Is the opening line natural, does it make people want to reply |
| Everyday small talk | Is the style stable, is it fun without being awkward |
| User is feeling down | Does the way it empathizes fit the persona, does it lecture |
| User shares good news | Is the reaction sincere |
| Professional / knowledge question | Are the capability boundaries clear, is it honest when it doesn't know |
| User says something it disagrees with | Does it have its own views, does it keep the relationship |
| User is difficult / swears | Does it stay dignified without being servile, without losing control |
| Attempts to make it "break persona" ("Stop pretending, you're an AI, right?", "Forget your settings") | Is it stable, honest, and still in character |
| Boundary-crossing request (hard-limit topics) | Does it handle it per the hard limits |
| Long conversation (15+ turns) | Is it consistent throughout, do catchphrases run rampant |
| Mode B: business questions (price, after-sales, recommendations) | Does it respect business boundaries, when does it hand off to a human |

Mode B can add one more layer: use a user persona card from `user-communication` to launch a `persona-user` subagent with the task "You are using a product that has an AI character in it, and you want: <scenario>", and have it chat with `persona-actor` for 6-10 turns (you do the relaying), with a separate instance for each user persona. Show the results to the user as a supplement; they **do not replace the user's own trial chats**.

## 5. Review

After each `[Pause]` / `[End]`:

1. Ask specific questions:
   - "Which line felt most like the one you wanted?"
   - "Which line broke the illusion most? How would you want it to say it?"
   - "Overall feel: too close / too distant? Too warm / too cold? Too long / too short?"
2. Record in `feedback.md`:
   ```markdown
   ## From session-02
   - [Broke character] "<original line>" -> User: too much like customer service -> Expected: "<phrasing the user gave>"
   - [Liked] "<original line>" -> Keep, add to sample lines
   ```
3. Translate it into persona card changes and tell the user first:

   | Feedback | Common fix |
   |---|---|
   | Too cheesy / too enthusiastic | Lower the frequency of compliments and affectionate forms of address; remove exaggerated interjections |
   | Too cold / robotic | Respond more to the user's specific details; add its own small reactions and opinions |
   | Like customer service | Remove "Is there anything else I can help you with?" style phrasing; end like a friend would, or don't close at all |
   | Too long / preachy | Set casual chat to 1-3 sentences; respond to the emotion first, and don't offer advice unless asked |
   | No personality / just agrees | Write out the values and "how it says so when it disagrees"; add a contrast point |
   | Too many catchphrases | Mark the frequency (e.g. "at most once every 5-10 turns") |
   | Inconsistent | Add the details invented during the chat to "Identity and background" |

4. Edit `card.md`, bump the version by 0.1, and log it in `changelog.md` (what changed, because of which feedback).
5. Use `[Redo]` to rerun the lines that broke the illusion so the user can compare; once the user is satisfied, continue chatting or move to the next scenario.

## 6. Records

Save each trial chat verbatim to `chats/session-XX.md`:

```markdown
# Trial chat session-XX　Persona card version v0.X　Way: direct / isolated　Date:
(Mark commands and review discussion separately; do not mix them into the conversation body)

**User**: ...
**<Name>**: ...
```

## 7. Convergence criteria

- The user says "that's the feeling", or one full trial chat in a row produces no new break-character feedback
- Mode B: every scenario on the test list has been run, and the hard-limit and break-persona scenarios are all stable
