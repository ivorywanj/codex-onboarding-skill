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

## Workflow

1. Confirm target agent and output location.
   - Default target agent: Codex.
   - Default output: `starter-pack/` in the current workspace or a user-provided folder.

2. Run low-friction intake.
   - Read `references/question-bank.md`.
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
