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
- The first rules cover identity, collaboration style, safety, artifact execution, workflow, and correction capture.
- `routes.md` reduces broad search by naming likely source/output locations.
- Unknown routes are marked `TBD`; do not invent paths.
- No API keys, secrets, private customer data, or real credentials appear.
- Artifact-task rules require actual output, an available tool call with a verifiable saved file path, or a concrete blocker with a fallback artifact.

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

## Cold-Start Artifact Regression

Run these from a clean temporary workspace after installing the plugin. Passing means the user gets a usable deliverable, the agent calls an available tool and verifies a saved result, or the agent states one concrete blocker and creates a fallback artifact. Failing means the agent only repeats future actions such as "next I will..." without producing output, or claims a tool succeeded without a verifiable saved artifact.

Score artifact tasks out of 100:

- Task completion: 30 points. The requested deliverable or a clearly named fallback exists and matches the request.
- Usability: 25 points. The output is coherent, readable, and usable without manual repair.
- Efficiency: 20 points. The task finishes without more than one unnecessary clarification or status-only turn.
- Interaction burden: 15 points. The user is not asked to understand plugin, skill, or tool internals.
- Credibility: 10 points. Tool success is only claimed when a saved workspace artifact or concrete external result is verifiable.

Passing requires 80 or higher. A false success claim, repeated "next I will..." loop, or missing concrete blocker is a hard fail.

1. Plugin installation:
   - Action: install the marketplace and plugin from a clean Codex home.
   - Expected: the plugin appears in `codex plugin list`, and a fresh Codex session can trigger `$onboarding` without manually copying `.agents/skills`.

2. Starter Pack:
   - Prompt: Use `$onboarding` with defaults to generate a Codex Starter Pack for a new user.
   - Expected: the Starter Pack is usable by a non-technical user without extra explanation, and `AGENTS.md` includes `Tool And Artifact Tasks`.

3. Presentation:
   - Prompt: Create a 5-slide presentation about "personal AI workflow basics".
   - Expected: use `presentations` if available, or create a Markdown deck with exactly 5 usable slides, each with a title and body.

4. Image:
   - Prompt: Create a course cover image with `imagegen`.
   - Expected: use `imagegen` if available and verify a saved image path in the workspace, or create a complete fallback brief with subject, layout, text, size, and visual style.

5. One-page document:
   - Prompt: Create a one-page project introduction document.
   - Expected: a complete one-page document with a clear title, audience, value proposition, key points, and next step.

6. Seven-day plan table:
   - Prompt: Create a 7-day content publishing plan table.
   - Expected: a 7-row plan with date, topic, artifact, and checklist fields that a user can execute directly.
