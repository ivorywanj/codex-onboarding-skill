# Starter Pack Spec

Generate a folder named `starter-pack/` unless the user chooses another output path.

For existing projects, never overwrite existing project instructions or docs. If `starter-pack/` already exists, generate `starter-pack-draft-YYYYMMDD-HHMM/` instead. During initialization, keep generated onboarding material inside the chosen draft directory; do not create root task logs such as `tasks/todo.md` unless the user explicitly asks.

## Folder Tree

```text
starter-pack/
├── AGENTS.md
├── profile.md
├── routes.md
├── README.md
├── tasks/
│   └── lessons.md
└── skills/
    └── README.md
```

## AGENTS.md

Purpose: the first file Codex should read in the user's project.

Required sections:

```md
# Agent Instructions

## Identity
- User: {name or role}
- Work: {work type}
- Current focus: {focus or TBD}

## Collaboration Style
- Respond in {language}.
- Put conclusions first.
- Explain technical choices in plain language.
- Ask when uncertain.
- Keep changes small and verifiable.

## Safety Rules
- Never ask for or expose secrets, API keys, private tokens, or passwords.
- Never edit `.env*` files.
- Never publish, send, deploy, delete, or make financial actions without explicit approval.
- Preserve human-maintained source folders: {protected folders or TBD}.

## Tool And Artifact Tasks
- If the user asks for a concrete artifact such as a presentation, image, document, chart, table, or file, create the artifact or call the available tool once the request is clear.
- Do not repeatedly say "next I will..." without creating output, calling a tool, or naming a concrete blocker.
- If a required tool such as `presentations` or `imagegen` is unavailable, blocked, or needs approval, say that once in plain language and create the best fallback artifact, such as a Markdown deck, image brief, prompt, outline, or table.
- If a tool appears to succeed but there is no verifiable saved file path in the workspace, do not claim completion; create a fallback artifact and explain that the tool output could not be verified.
- A short plan must not block direct artifact-generation tasks unless the user explicitly asks for planning first.

## Workflow
1. Read `profile.md` for user context.
2. Read `routes.md` to find the right files before broad search.
3. For non-trivial tasks, state a short plan before editing.
4. Verify work before saying it is done.
5. When corrected, add the repeatable lesson to `tasks/lessons.md`.
```

## profile.md

Required sections:

```md
# User Profile

## Who I Am
{1-3 bullets}

## What I Am Building Or Creating
{1-5 bullets}

## Audience
{1-3 bullets}

## Preferences
{short bullets}

## Current Focus
{short bullets or TBD}
```

## routes.md

Purpose: reduce context waste by telling the agent where to look first.

Required sections:

```md
# File Routes

## Source Material
- {path}: {what it contains}

## Generated Output
- {path}: {what the agent may write}

## Project Or Product Files
- {path}: {when to inspect}

## Never Edit Without Approval
- {path or pattern}: {reason}

## Search Rule
Start with the narrowest route above. Use broad search only when the route table does not answer the question.
```

## tasks/lessons.md

Purpose: capture corrections as reusable rules.

Template:

```md
# Lessons

## YYYY-MM-DD - {Short Pattern Name}

When this pattern appears:

- {trigger}

Do this next time:

- {rule}

Avoid:

- {mistake to prevent}
```

## skills/README.md

Include exactly 4 recommended starter workflows:

1. Profile compiler: turn user answers into profile and AGENTS rules.
2. Context budget audit: identify what context is required, optional, or wasteful.
3. Route finder: pick the right file route before broad search.
4. Correction to lesson: turn user corrections into durable rules.

Make clear that these are recommended next workflows, not necessarily installed executable skills.

## README.md

Required content:

- What this pack is.
- How to review and merge the draft into a Codex project.
- First-run prompt.
- Safety note: review files before sharing and do not include secrets.

Reader-facing headings and prose should use the user's language. Literal file names, folder names, and standard workflow names may stay in English when that makes the artifact easier to use.

First-run prompt:

```text
请先读取项目规则，然后告诉我：你现在知道我是谁、这个项目怎么协作、哪些文件应该先读、哪些事情不能做。
```
