---
name: onboarding
description: Create a low-friction Codex Starter Pack for people from any background or profession. Use when the user asks to make an AI agent understand them, generate a Codex Starter Pack, create onboarding files such as AGENTS.md/profile/routes/tasks/lessons, set up personal or project rules for Codex, reduce repeated context, save tokens with routing instructions, or recommend starter workflows for an AI agent.
---

# Onboarding

## Purpose

Generate a semi-automatic Codex Starter Pack that helps an AI agent understand a user, find the right files, avoid unsafe actions, and use a few starter workflows without requiring long explanations.

Default audience: anyone who wants an AI agent to understand their work context without learning agent internals, including individuals, teams, learners, and professionals.

## Ground Rules

- Keep onboarding choice-first: use single-choice or multi-choice questions whenever possible.
- Ask at most 3 questions per turn.
- Give a recommended default for every choice question.
- Use open text only for short facts such as names, project paths, source folders, or custom forbidden actions.
- Do not require users to understand terms like `AGENTS.md`, token, routes, or skills; explain these as "agent instructions", "less repeated context", "where files live", and "reusable workflows".
- Never ask for API keys, passwords, private tokens, or customer/private data.
- Do not write into user machine config, global Codex config, or hidden agent directories unless the user explicitly asks. First version is semi-automatic.
- If target files already exist, create a draft under `starter-pack/` instead of overwriting.
- Do not generate the first Starter Pack until the user has answered the initial preference intake or explicitly said to use recommended defaults.

## Install-To-Initialize Handoff

Use this when the user asks to install this onboarding plugin from a GitHub link, zip file, or local folder.

- Treat installation and first initialization as one workflow. Do not tell the user to copy `$onboarding` into a new chat as the next required step.
- If the user gives a GitHub repo or URL, install it with `codex plugin marketplace add <source> --ref <ref>` and then `codex plugin add codex-onboarding-skill@codex-onboarding`.
- If the user gives a `.zip` path, unzip it into `/tmp/codex-onboarding-install-*`, locate `.agents/plugins/marketplace.json` or `.codex-plugin/marketplace.json`, install from that extracted root, and do not copy the zip contents into the user's project.
- If the user gives a local extracted folder, locate the marketplace manifest and install from that folder.
- After install, verify `codex plugin list` shows `codex-onboarding-skill@codex-onboarding` as installed and enabled.
- Then ask in the current conversation: `已装好。要开始初始化吗？我会先问 3 个偏好选择题；你也可以直接说“用推荐默认值”。`
- If the user already asked to install and initialize in one sentence, continue directly to the initial preference intake instead of generating files immediately.
- Default to initializing the current workspace after intake. Offer only two alternatives when needed: choose another project path, or skip initialization for now.
- If the newly installed skill is not visible in the current session, continue by reading this `SKILL.md` from the installed plugin cache or the source repository and follow it directly for the first initialization.

## Initial Preference Intake Gate

Use this before generating the first Starter Pack, including install-and-initialize requests.

- Ask Batch 1 from `references/question-bank.md` first, translated into the user's language.
- Ask all 3 questions in one turn with recommended defaults.
- Do not infer personal preferences only from the install request, repository name, current directory, or README.
- If the user says "use defaults", "用默认", "你帮我选", or "跳过问答", proceed with recommended defaults and record those defaults in the draft.
- Existing project context may fill project routes and protected files, but it does not replace personal preference intake.

## Existing Project Initialization

Use this when initializing an existing project or workspace.

- Prefer the current Codex workspace as the target project when it contains `.git`, `README*`, `package.json`, `pyproject.toml`, `Cargo.toml`, `docs/`, `src/`, or other normal project files.
- If the current workspace looks empty or unrelated, ask for one short project path.
- Inspect only lightweight project context before generating: top-level tree, `README*`, existing `AGENTS.md`, and obvious docs folders. Do not inspect `.env*`, private keys, credentials, build artifacts, or large generated folders.
- Do not overwrite existing `AGENTS.md`, `README.md`, `tasks/lessons.md`, or `starter-pack/`.
- Default output is `<project>/starter-pack/`.
- If `<project>/starter-pack/` already exists, output to `<project>/starter-pack-draft-YYYYMMDD-HHMM/`.
- During initialization, write generated onboarding material inside the chosen draft directory only; do not create root task logs such as `<project>/tasks/todo.md` unless the user explicitly asks.
- Adapt the generated Starter Pack to the existing project name, visible folder layout, existing docs, and known safety boundaries. Use `TBD` when unsure instead of inventing paths.
- Handoff with the generated folder path and the safest next step for reviewing or merging the draft into the project.

## Workflow

1. Confirm target agent and output location.
   - Default target agent: Codex.
   - Default output: `starter-pack/` in the current workspace or a user-provided folder.
   - For an existing project, use the existing project initialization rules above.

2. Run low-friction intake.
   - Read `references/question-bank.md`.
   - For the first Starter Pack, run the initial preference intake gate above before generating files.
   - Ask questions in small batches.
   - Prefer defaults when the user says "use default", "你帮我选", or gives partial answers.
   - Mark unknown details as `TBD` rather than blocking the flow.

3. Generate the Starter Pack.
   - Read `references/starter-pack-spec.md`.
   - Create these files in the output folder:
     - `AGENTS.md`
     - `profile.md`
     - `routes.md`
     - `tasks/lessons.md`
     - `skills/README.md`
     - `README.md`
   - Ensure `AGENTS.md` includes artifact-task rules that require the agent to create the requested output, call an available tool with a verifiable saved result, or name a concrete blocker with a fallback artifact.
   - Keep files concise and actionable. Avoid bloated personal biographies or generic AI advice.

4. Recommend starter workflows.
   - Include exactly 4 starter skills/workflows in `skills/README.md` unless the user asks for more:
     - Profile compiler
     - Context budget audit
     - Route finder
     - Correction to lesson
   - Present them as recommended next workflows, not as installed executable skills unless you actually create those skill folders.

5. Validate before handoff.
   - Read `references/validation.md`.
   - Check file completeness, UX burden, safety boundaries, and first-run prompt.
   - Show the user the generated first-run prompt and a short done-check.

## Output Style

- Write generated Starter Pack content in the user's language.
- Translate reader-facing headings and prose into the user's language; keep literal file names and standard workflow names only when useful.
- Use plain language and short sections.
- Put the most important rules first.
- Prefer "do / do not" instructions over essays.
- Avoid fabricated URLs, unverified dependencies, and hardcoded secrets.

## When User Context Is Thin

If the user gives very little information, create a useful starter pack with safe defaults:

- identity: individual user / team member
- agent target: Codex
- collaboration style: concise, ask when uncertain, verify before done
- safety: no secrets, no destructive actions without confirmation, no publishing without approval
- routes: `TBD` placeholders with examples
- workflows: profile, routing, context budget, correction capture

This safe-default path applies only after the user explicitly chooses defaults or skips intake.
