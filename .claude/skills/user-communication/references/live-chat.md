# The User Talks Directly to a Simulated User

Let the user (product manager, founder, operations, sales…) **personally** talk to a generated persona: ask their own questions, follow up themselves, and try their own talk tracks. The main agent no longer plays the interviewer and acts only as a **relay + off-stage coach**.

Use cases:
- Wanting to "hear" a certain type of user in their own words, rather than just reading interview records
- Practicing before real interviews: practice asking, following up, and handling awkward silences and refusals
- Trying out communication talk tracks / sales talk tracks / customer service replies: send the messages yourself and see how this user replies
- Feeling that a persona is "off" and wanting to find out what is wrong through conversation

## 1. Before the chat

1. Confirm which persona to talk to (`personas/P0X-<short-name>.md`). If there is no persona card, go back to step 2 and generate one first.
2. Confirm the **conversation setting**: in what role and on what occasion the user is speaking to this person. The setting goes into the subagent's launch prompt and must be described neutrally:

   | Setting | Example description in the launch prompt |
   |---|---|
   | User interview (default) | You agreed to a 30-minute online interview. The other party is a researcher at a company who wants to learn about your experience in [field] |
   | Private message outreach | You received a friend request on WeChat from a stranger, and after you accepted, they sent you a message |
   | Follow-up call | You previously left your phone number with [some product], and now you are getting a call from them |
   | Sales visit (B2B) | The other party is a salesperson at a software company who booked 20 minutes to talk with you |
   | Community / comment section | You are in a group about [topic], and someone @-mentioned you |
   | Customer service / after-sales | You ran into a problem while using [some product] and contacted customer service |

   In the setting, **write only what this person could perceive**. Do not include details of our product plan, hypotheses, or "what we want to validate". If the product needs to be introduced, let the user do it themselves in the conversation.
3. Tell the user how it works:

   > From here on you talk directly to **<persona name>**. I will relay everything you say to them verbatim, and relay their replies back to you verbatim. They know only their own persona, not the research we have done.
   > Commands (I handle these and they are not forwarded to them):
   > - `[Pause]` or starting a line with `##`: stop and discuss with me (e.g. "How should I follow up on that next?")
   > - `[Resume]`: go back to the conversation
   > - `[Redo]`: retract your last line and ask it a different way (they will "forget" your last line)
   > - `[Switch to P02]`: switch to another persona; when you switch back, the earlier conversation picks up where it left off
   > - `[Ask everyone] <content>`: send the same line to all personas (each answers independently, unaware of the others)
   > - `[End]`: end the conversation and move to the debrief

## 2. During the chat

### Launching the subagent
Launch one independent `persona-user` subagent per persona (do not have the main agent play it itself, because the main conversation holds research conclusions and hypotheses that would contaminate the role). The prompt contains only:

```
Your persona card file: user-research/<product-name>/personas/P01-<short-name>.md
Mode: chat
Setting: <neutral description from the table above>
Read the persona card first, then step into the setting as that user. The other party's first line is:
<the user's first line, verbatim>
```

If the user wants the persona to speak first (e.g. in a customer service setting), replace the last line with "Say your first line."

### Relay rules
- Send the user's words to the same subagent **verbatim** with SendMessage (before first use, load it with ToolSearch `select:SendMessage`). Do not polish them, fix typos, add background, or follow up on the user's behalf.
- Relay the subagent's replies to the user **verbatim**, prefixed with `<persona name>:`. Do not summarize, interpret, or add commentary after each one.
- Never pass any "guidance" to the subagent ("be more realistic", "the user wants to hear…"). If the persona feels off, change the persona card (see section 4).
- The main agent handles user commands and does not forward them.

### Command handling
| Command | Handling |
|---|---|
| `[Pause]` / `##…` | Stop relaying and respond as the coach. You may suggest follow-ups, point out a leading question just asked, or explain the possible subtext of something they said, but **do not send messages for the user**; the user decides what to say next |
| `[Resume]` | Resume relaying |
| `[Redo]` | A subagent cannot forget, so: launch a fresh `persona-user` instance, attach the "previous conversation record" to the prompt (up to just before the user's last line), then send the user's new phrasing. Discard the old instance. Keep both versions in the record so the difference in phrasing can be compared |
| `[Switch to P0X]` | If that persona already has an instance, continue with SendMessage; if not, launch a new one using the template above. Never pass conversation content between different personas |
| `[Ask everyone]` | Send the same line to every persona that is already running or needs to be launched (in parallel), and show the replies separated by persona. Do not carry A's answer over to B |
| `[End]` | Move to the debrief |

If the user writes a cross-persona reference during the chat, such as "Everyone else says… what do you think?", relay it as usual (it is the user's choice), but flag it in the debrief: it introduces an anchoring effect into the answers.

## 3. Debrief

After `[End]`, do the following as the user wants (ask which ones they want first):

1. **What was heard**: excerpt the key information from this conversation as "verbatim quote + scenario": pain points, alternatives, spending, concerns, emotionally charged points, and contradictions. It can feed directly into step 7 (Organize and extract insights), with the source labeled "User's own conversation · simulated".
2. **How the questioning went** (interview coach): critique the user's questions one by one against The Mom Test, flagging only the problematic lines and giving rewrites:

   ```markdown
   | User's original line | Problem | Suggested rewrite |
   |---|---|---|
   | "If there were a tool that tracked expenses automatically, would you use it?" | Asks about a future hypothetical; the answer isn't reliable | "How did you track expenses last month? How long did it take?" |
   | "Isn't this feature really convenient?" | Leading, closed question | "What do you think of this? What makes you hesitate the most?" |
   | (After they said "it's a hassle," moved straight to another topic) | Missed follow-up | "Which step is the hassle? When did it last happen?" |
   ```

   Also point out what went well (good follow-ups, well-placed silence, getting a behavioral commitment).
3. **Talk track test conclusions** (talk track settings): at which line they started to lose interest / get guarded / feel moved; which words they didn't understand; how to revise the talk track, which can then be retried with `[Redo]` or on a different persona.
4. **Is the persona credible**: ask the user, "Was there any line where you thought 'a real user wouldn't say that'?" The user often knows real users better than the persona card does.

## 4. Adjusting the persona card

When the user thinks the persona is unrealistic:
1. First ask for the basis: "What are the users of this type you've met actually like?" **Adjustments must be based on the user's real experience or evidence**, and never made because "we want them to be more interested in the product". If the user's changes are clearly making the persona more receptive to their own plan, point that out.
2. Edit the corresponding fields of the persona card, and add a source line at the end of the card: `- <field>: adjusted based on <user>'s firsthand experience (date)` (put only the source here, not product hypotheses from the adjustment rationale).
3. Subagents already launched do not update automatically: to continue the conversation, relaunch an instance with the new persona card and attach the "previous conversation record".

## 5. Recording

Save each conversation verbatim to `interviews/P0X-<short-name>-live-XX.md`:

```markdown
# The user's own conversation with a simulated user live-XX
> Simulated conversation, not a real user. Persona: P0X-<short-name>  Setting: <setting>  Date:

**Us**: …
**<persona name>**: …

(Keep both versions of a [Redo], labeled "before redo / after redo"; discussion during pauses is not mixed into the main text and goes in a "Debrief" section at the end)
```
