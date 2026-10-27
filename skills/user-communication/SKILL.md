---
name: user-communication
description: User communication and user insight. Use it to identify the product's different target user types, build user personas, generate a user tag system, design interview guides and surveys, and prepare talk tracks. It also launches an independent persona-user subagent for each persona to run simulated interviews (contexts isolated from each other), lets the user talk directly to a generated persona (ask questions yourself, practice interviewing, try out your script), and finally organizes interview records and extracts insights. Use when the user mentions "user persona", "user tags", "target users", "user interview", "simulated user", "user communication", "survey design", "user segmentation", "interview analysis", "let me talk to this user", "I want to ask them directly", "practice interviewing", or "try out my script".
---

# User Communication

Goal: figure out **who the product's target users are and what they look like**, give them actionable tags, and design **effective ways to communicate** with them to validate needs, collect feedback, and drive conversion.

This skill often pairs with the `product-research` skill: the "user groups" and "list of questions to validate" in a research report are inputs to this skill, and the interview conclusions from this skill can be written back to the research report.

## Workflow

### 0. Clarify the purpose of the communication

First confirm what this round of user communication is for. A different purpose means a completely different audience and method:

| Purpose | Typical methods | Audience |
|---|---|---|
| Need discovery (0→1) | In-depth interviews, observation | Potential users, users of alternatives |
| Need validation | Problem interviews, fake-door tests, surveys | Target segment users |
| Solution/prototype validation | Usability tests, concept tests | Early users |
| Satisfaction and churn reasons | NPS, churn interviews | Active users, churned users |
| Conversion/promotion | Talk tracks, outreach copy | Users from each channel |

Also confirm: what the product is, what stage it is at, and any existing user data or research conclusions.

---

### 1. Identify target user types

1. **List all relevant roles**: users, buyers/payers, decision-makers, influencers, gatekeepers (especially important in B2B).
2. **Do an initial segmentation.** Common segmentation dimensions:
   - Need/scenario: what task they are trying to get done, and in what scenario they use the product
   - Behavior: frequency of use, depth of use, current alternative
   - Value: willingness to pay, ability to pay, lifetime value
   - Demographics: age, city tier, occupation, income (B2C); industry, size, role (B2B)
3. **Set priorities**: score with "size × need intensity × reachability × willingness to pay", then pick the **core users (seed users)**, secondary users, and non-target users (explicitly, who you do not serve).

### 2. Build user personas

Produce one persona card for each core user type, **and save each persona as its own file** (so the subagents in steps 5 and 6 can read it):

```
user-research/<product-name>/
├── personas/        # One file per persona: P01-<short-name>.md, P02-<short-name>.md …
├── interviews/      # One interview record per persona: P01-<short-name>.md …
└── report.md        # User communication plan + insight summary
```

Persona card template (`personas/P0X-<short-name>.md`):

```markdown
# Persona: [Name + one-line tag, e.g. "Efficiency-anxious small shop owner, Lao Wang"]

## Basic information
Age / city / occupation / income / family (B2B: company size / industry / job title / reporting line)

## Typical scenarios
When, where, and why the need gets triggered during the day

## Goals (Jobs-to-be-Done)
Functional tasks / emotional needs / social needs

## Pain points
What they dislike about the current solution (ranked by severity)

## Existing alternatives
How they solve it today, and how much money/time it costs

## Decision factors
What matters most when choosing a product (price / results / word of mouth / security / convenience)

## Information channels
Where they get information and whom they trust

## Personality and communication style
Personality traits, way of speaking, catchphrases, attitude toward strangers/new products, digital literacy

## Knowledge boundaries
What they know and don't know (industry jargon, technical concepts)

## Budget and payment habits
Disposable budget, how much they have paid for similar problems in the past, payment decision process

## Hidden motives / real concerns
What they won't volunteer and only reveal when pressed (e.g. afraid the boss will think they are unprofessional)

## Typical quote
One sentence that represents their mindset
```

Personas must be **evidence-based** (data, interviews, reviews, public sources), and you must mark which parts are hypotheses still to be validated.

**Never write the following into a persona file**: details of our product plan, research conclusions, hypotheses to validate, or information about other personas. Otherwise the simulated user gets "contaminated" and ends up confirming our hypotheses. Analysis such as "what this means for our product" goes in `report.md`, not in the persona file.

### 3. Generate the user tag system

Tags are used for segmented operations, precise outreach, and data analysis. Organize them in five layers:

| Tag layer | Description | Examples |
|---|---|---|
| Basic attribute tags | Static demographic/company attributes | Gender, age range, city tier, occupation; industry, company size |
| Behavior tags | From behavioral data | New/returning user, activity level (high/medium/low/dormant), frequency of use, preferred features, source channel |
| Value tags | Business value | Payment status, RFM tiers (important value / important development / important retention / important win-back…), LTV tier |
| Need/preference tags | From interviews, surveys, content preferences | Price-sensitive, efficiency-oriented, quality-oriented, socially driven |
| Predictive tags | Model predictions | Churn risk, purchase intent, willingness to recommend |

For each tag, define: **tag name / layer / definition and calculation rule / data source / update frequency / purpose**.

Output example:

| Tag name | Layer | Rule | Data source | Update | Purpose |
|---|---|---|---|---|---|
| Highly active | Behavior | Active ≥ 15 days in the last 30 days | Event-tracking logs | Daily | Beta invitations, word-of-mouth spreading |
| Price-sensitive | Need/preference | Only orders during promotions, or picks "price matters most" in the survey | Orders + survey | Weekly | Targeted coupon pushes |
| Churn warning | Predictive | Active days down > 50% period over period | Model | Daily | Win-back outreach |

### 4. Design user communication

#### 4.1 Recruiting and screening
- Write a **screener survey** (5–8 questions) to exclude non-target users, competitor employees, and professional respondents.
- Interview 5–8 people per segment (stop when information starts repeating, i.e. saturation).
- Channels: existing user base, communities, competitor review sections, industry groups, referrals from friends, paid recruiting platforms.

#### 4.2 Interview guide (in-depth interview, 45–60 minutes)

```markdown
1. Opening (5 min): introduce yourself, explain the purpose, promise confidentiality, get consent to record
2. Background (5–10 min): who the interviewee is, their daily work/life rhythm
3. Scenarios and behavior (15–20 min):
   - "When was the last time you ran into [problem]? What exactly happened?"
   - "How did you solve it? Which tools did you use / who did you turn to?"
   - "Which step in the whole process was the most troublesome?"
4. Pain points and costs (10 min):
   - "What impact did this problem have on you? How much time/money did it cost?"
   - "Have you tried other approaches? Why did you give up on them?"
5. Solution feedback (optional, 10 min): show a concept/prototype and observe the reaction instead of asking "do you like it?"
6. Willingness to pay (5 min): how much do they pay for this now? Validate with behavioral commitments (sign up, prepay, leave contact details)
7. Closing: anything else to add? Can they refer other people?
```

#### 4.3 Questioning principles (The Mom Test)
- Ask about **specific past behavior**, not future hypotheticals (❌ "Would you use it?" ✅ "How did you do it last time?")
- Ask about **facts**, not opinions; don't pitch your own ideas
- Keep asking "why", "can you give an example?", and "and then?"
- Avoid leading and closed questions; silence is a good tool
- Beware of compliments and politeness: they are not data

#### 4.4 Survey design (quantitative validation)
- Do interviews first and the survey second; use the survey to validate size and proportions
- Structure: screener questions → behavior questions → attitude questions → demographic questions
- Single/multiple-choice options should be mutually exclusive and collectively exhaustive; use a consistent scale (5 or 7 points); keep it under 5 minutes
- You can add NPS (0–10 likelihood to recommend) and Kano questions (asking in both the positive and negative direction to determine the type of need)

#### 4.5 Talk tracks / outreach copy
Design differentiated communication for each user tag/persona:

| User group | Core need | Communication angle | Sample talk track/copy | Outreach channel | Timing |
|---|---|---|---|---|---|

Talk track requirements: use the users' own language (from verbatim interview quotes), talk about the pain point before the value, and give a clear call to action.

### 5. Simulated user interviews (one independent subagent per persona)

Once the personas and interview guide are ready, launch **one independent `persona-user` subagent per persona** to run the interview. The purpose: each simulated user knows only their own persona and is not influenced by other personas, product research conclusions, or the main conversation context.

> **Launching `persona-user`.** Installed as a Claude Code plugin, the subagent type is `product-discovery:persona-user` (or `persona-user` if it was copied into `.claude/agents/`). If no such subagent type exists (e.g. the skill was installed with `npx skills`, or you are running in Codex), launch a generic subagent instead (`general-purpose` in Claude Code, a spawned sub-agent in Codex) and begin its prompt with the full contents of `references/persona-user-role.md`, followed by the usual launch prompt. The isolation rules stay the same. If the host has no subagents at all, tell the user the role can't be isolated here and ask before playing it in the main conversation.

#### 5.1 Isolation rules (must follow)
- **One persona = one subagent instance.** Never let one subagent play multiple users.
- When launching a subagent, the prompt **contains only**: the persona file path + the interview questions (+ a neutral description of the product for concept tests). Do not pass in the research report, the list of hypotheses, other personas, or "what we hope to hear".
- Subagents do not pass information to each other. Do not use user A's answer as material for questions to user B ("Everyone else says… what do you think?").
- The main agent plays the interviewer and is only responsible for asking questions and follow-ups.

#### 5.2 Steps
1. **Launch in parallel**: in a single message, call the Agent tool once per persona (`subagent_type: "persona-user"`). Prompt template:

   ```
   Your persona card file: user-research/<product-name>/personas/P01-<short-name>.md
   Read the persona card first, then answer the following interview questions as that user:

   [Opening note: who the interviewer is, the purpose of the interview (in neutral wording, without exposing hypotheses)]

   Q1: ...
   Q2: ...
   ...
   ```

   The first round asks only the **background + scenarios and behavior + pain points and costs** sections (sections 2–4 of the guide) and does not show the product plan.

2. **Follow up (multiple rounds)**: read each user's answers and design follow-ups for points that are vague, contradictory, or emotional ("Can you tell me more about the last time…", "Why?", "And then?"). Send them with SendMessage to the **same subagent** (by the agent ID / name it returned) so that user's context stays continuous. Do 1–3 follow-up rounds per user. (SendMessage is a deferred-load tool; before first use, load it with ToolSearch `select:SendMessage`.)
3. **Solution feedback / willingness to pay** (optional): in the last round, show the product concept (neutral description, no exaggeration), ask for their reaction, and ask for a behavioral commitment (sign up, prepay, leave contact details).
4. **Record**: write each user's complete Q&A (including follow-ups) verbatim to `interviews/P0X-<short-name>.md`, and note "Simulated interview, not a real user" at the top.
5. The same approach also works for: **survey pre-testing** (check whether questions are misunderstood) and **talk track testing** (send the talk tracks from 4.5 to the matching persona and see the reaction).

#### 5.3 Notes
- Simulated interviews are for **polishing the guide, anticipating reactions, and finding blind spots**. They cannot replace real user interviews. Always label conclusions "Simulated result, to be validated with real users".
- If all simulated users react positively to the product, suspect bias in the personas or the questions first, rather than concluding the product works.

### 6. The user talks directly to a simulated user

Besides having the main agent interview on their behalf, the user can also **step in personally**: chat directly with a persona, asking questions, following up, sending talk tracks, and introducing the product themselves, to see how this user responds. Good for: wanting to hear a certain type of user in their own words, practicing before real interviews, testing communication/sales talk tracks, and checking whether a persona feels real.

Key points (see `references/live-chat.md` for the detailed process, commands, and debrief approach; read it before starting):
- **The role is still played by a `persona-user` subagent.** The main agent does not play it itself (the main conversation holds research conclusions that would contaminate the role). One persona per instance, with the same isolation rules as step 5.
- Before starting, confirm the **conversation setting** with the user (interview / WeChat private chat / follow-up call / sales visit…), write it as a neutral description into the launch prompt, and mark `Mode: chat` in the prompt.
- The main agent is a **relay + off-stage coach**: pass the user's words to the subagent verbatim via SendMessage and return the replies verbatim; do not polish them, ask questions for the user, or give the subagent any "guidance".
- The user controls the session with commands: `[Pause]` / `##` (talk to the coach), `[Resume]`, `[Redo]` (retract the last line and ask it differently), `[Switch to P0X]`, `[Ask everyone]`, `[End]`.
- After `[End]`, debrief: what was heard (feeds into step 7), commentary on questioning technique (Mom Test, with rewrites), how the talk track worked, and whether the persona is credible.
- When the user thinks a persona is unrealistic, revise the persona card based on the user's firsthand experience and note the source; **never change it to make the persona more receptive to the product**.
- Save the conversation verbatim to `interviews/P0X-<short-name>-live-XX.md`, labeled "Simulated conversation, not a real user".

### 7. Organize and extract insights

After you have interview records (simulated interviews / the user's own conversations in `interviews/`, or real interview notes) or user feedback:
1. **Excerpt item by item**: verbatim quote + interviewee tag + scenario
2. **Affinity clustering**: group similar viewpoints and name the themes
3. **Extract insights**: use the format "[some type of user] in [scenario] needs [what], because [deeper reason], but currently [obstacle]"
4. **Validate hypotheses**: check against the "list of questions to validate" from product-research, marking each ✅ confirmed / ❌ refuted / ❓ insufficient evidence
5. **Action recommendations**: give adjustment suggestions for the product, personas, tags, and channels, and update the persona cards

---

## Output format

Output the relevant parts depending on what the user needs. The full structure:

```markdown
# [Product name] User Communication Plan

## 1. Communication purpose and scope
## 2. Target user segments and priorities
## 3. User personas (one persona card per type)
## 4. User tag system
## 5. Communication plan
   - Recruiting and screener survey
   - Interview guide
   - Survey (if needed)
   - Talk tracks by segment
## 6. Simulated interview overview (summary of each persona's subagent interview and the user's own conversations, linked to interviews/)
## 7. Insights and conclusions (note the source: simulated / real)
## 8. Hypothesis validation results & next steps (questions that need real-user validation)
```

Write the plan to `user-research/<product-name>/report.md`.

## Principles

- **What users say ≠ what users do**: behavioral evidence takes priority over stated opinions.
- **Personas are hypotheses and need continuous validation**: update them after every round of communication.
- **Tags must be usable**: every tag must correspond to an operational action or an analytical purpose; otherwise don't create it.
- **Respect users**: protect privacy, get consent, and don't over-contact them.
