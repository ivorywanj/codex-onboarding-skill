# Validation

Run these checks before handoff.

## File Completeness

- `AGENTS.md` exists.
- `profile.md` exists.
- `routes.md` exists.
- `tasks/lessons.md` exists.
- `skills/README.md` exists.
- `README.md` exists.

## UX Acceptance

- At least 80% of intake questions can be answered by choosing options.
- No open question requires more than 1-2 sentences.
- The user can complete onboarding without understanding `AGENTS.md`, skills, token budgets, routes, MCP, or memory internals.
- Single turn asks no more than 3 questions.
- Each choice question includes a recommended default.

## Content Quality

- The generated `AGENTS.md` is concise enough to scan.
- The first rules cover identity, collaboration style, safety, workflow, and correction capture.
- `routes.md` reduces broad search by naming likely source/output locations.
- Unknown routes are marked `TBD`; do not invent paths.
- No API keys, secrets, private customer data, or real credentials appear.

## Live Trigger Simulation

Use a representative request such as:

```text
请使用 onboarding skill，帮我生成一个 Codex Starter Pack。我是新用户，希望 Agent 先懂我的工作方式、少读无关文件、不要让我写很多字。
```

Expected behavior:

1. The skill asks at most 3 low-burden questions, mostly choices.
2. The skill can proceed with safe defaults if the user chooses defaults.
3. The skill produces the Starter Pack tree and contents.
4. The handoff includes the first-run prompt.
