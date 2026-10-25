# Key Points for Writing Agent Prompts

## Core principles

1. **Explain goals and reasons instead of piling on rules**: only when the model understands "why" can it do the right thing in situations the prompt doesn't cover.
   - ❌ "Answer in no more than 200 words."
   - ✅ "Users read this on their phones and usually only want to know what to do next, so lead with the conclusion and keep it under 200 words; expand if the user asks a follow-up."
2. **Describe the desired behavior positively**: saying what to do works better than listing a pile of "don'ts"; list the true no-go areas separately.
3. **Give real examples**: 1–3 user-provided inputs → ideal outputs. Make the examples varied so the model doesn't learn to copy just one format.
4. **State boundaries and escalation conditions clearly**: when to stop and ask a person, refuse, or hand off to a human, written as conditions that can be checked.
5. **Define the output format**: structure, fields, length, language; for output consumed by downstream programs, give the exact format.
6. **Write tool descriptions as "when to use"**: for each tool, state its purpose, when to use it, and when not to.
7. **Keep the tone restrained**: avoid all caps and overuse of "absolutely" and "must"; emphasize only where it really matters.
8. **Control length**: write only what changes behavior; don't write things the model would do well anyway.

## Common problems → how to fix them

| Problem seen in trial runs | Fix |
|---|---|
| Output too long / too short | State the reader and use scenario, give a length target and an example |
| Unstable format | Provide an explicit template; when the downstream consumer is a program, provide a JSON schema |
| Makes things up when information is insufficient | State "when unsure: say what is missing + give a version with stated assumptions / ask first" |
| Asks too many questions, slow to start working | State "only ask when these specific pieces of information are missing; use defaults for everything else and flag them" |
| Takes external actions on its own | List the actions that need confirmation as a checklist, and tighten permissions at the tool level |
| Wrong tone | Replace adjectives with a style sample the user has chosen |
| Copies the examples | Add more variety to the examples and explain that they only illustrate style and structure |
| Goes off topic, does things out of scope | State the responsibility boundaries and "when something is out of scope, what to suggest the user do" |

## Self-check

- [ ] Someone who never took part in the discussion could read the prompt and know what to do, why, and to what extent
- [ ] Every rule maps to a requirement in the spec
- [ ] Contains at least 1 real example
- [ ] Actions that need confirmation and failure handling are clearly written
