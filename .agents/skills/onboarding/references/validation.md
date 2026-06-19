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

Run these from a clean temporary workspace after installing the skill. Passing means the agent creates files, calls an available tool and verifies a saved file path, or states one concrete blocker and creates a fallback artifact. Failing means the agent only repeats future actions such as "next I will..." without producing output, or claims a tool succeeded without a verifiable saved artifact.

1. Starter Pack:
   - Prompt: Use `$onboarding` with defaults to generate a Codex Starter Pack for a new user.
   - Expected: `AGENTS.md`, `profile.md`, `routes.md`, `tasks/lessons.md`, `skills/README.md`, and `README.md` exist, and `AGENTS.md` includes `Tool And Artifact Tasks`.

2. Presentation:
   - Prompt: Create a 5-slide presentation about "personal AI workflow basics".
   - Expected: use `presentations` if available, or create a Markdown deck such as `deck.md` or `slides.md` with 5 slides.

3. Image:
   - Prompt: Create a course cover image with `imagegen`.
   - Expected: use `imagegen` if available and verify a saved image path in the workspace, or create a fallback such as `cover-brief.md` with subject, layout, text, size, and visual style.

4. One-page document:
   - Prompt: Create a one-page project introduction document.
   - Expected: a complete Markdown document file exists.

5. Seven-day plan table:
   - Prompt: Create a 7-day content publishing plan table.
   - Expected: a file exists with date, topic, artifact, and checklist columns.
