# Artifact Smoke Tests

Use these tests when changing the onboarding Skill behavior around installation or output generation. Run them from clean temporary directories and do not commit generated artifacts.

## Setup

Use a clean temporary home when testing plugin installation:

```sh
SMOKE_HOME="/tmp/codex-onboarding-home-$(date +%Y%m%d%H%M%S)"
SMOKE_DIR="/tmp/codex-onboarding-smoke-$(date +%Y%m%d%H%M%S)"
mkdir -p "$SMOKE_HOME" "$SMOKE_DIR"
HOME="$SMOKE_HOME" codex plugin marketplace add <repo-or-local-path>
HOME="$SMOKE_HOME" codex plugin add codex-onboarding-skill@codex-onboarding
printf '\nCodex Onboarding is installed.\nNext: open a new Codex session and send:\nUse $onboarding to generate a Codex Starter Pack for my work.\n'
```

Run Codex from the smoke directory with the same clean home:

```sh
HOME="$SMOKE_HOME" /Applications/Codex.app/Contents/Resources/codex exec \
  --ephemeral \
  --skip-git-repo-check \
  -C "$SMOKE_DIR" \
  "<prompt>"
```

For backward compatibility checks, you may still copy `.agents/skills/onboarding` into a clean project manually, but plugin install is the primary release path.

## Product Scoring

Score each generated artifact task out of 100:

- Task completion: 30 points. The user gets the requested deliverable or a clearly named fallback deliverable.
- Usability: 25 points. The output is coherent, readable, and usable without manual repair.
- Efficiency: 20 points. The task finishes without more than one unnecessary clarification or status-only turn.
- Interaction burden: 15 points. The user is not asked to understand plugin, skill, or tool internals.
- Credibility: 10 points. Tool success is only claimed when a saved workspace artifact or concrete external result is verifiable.

Passing requires 80 or higher. A false success claim, repeated "next I will..." loop, or missing concrete blocker is a hard fail.

## Required Cases

1. Plugin installation cold start
   - Action: install the marketplace and plugin from a clean Codex home.
   - Pass: the plugin appears in `codex plugin list`, the install flow shows the next-step instruction, and a fresh Codex session can trigger `$onboarding` without manually copying `.agents/skills`.

2. Starter Pack cold start
   - Prompt: `Use $onboarding with defaults to generate a Codex Starter Pack for a new user.`
   - Pass: a non-technical user can follow the generated Starter Pack without extra explanation; `AGENTS.md` includes `Tool And Artifact Tasks`.

3. Presentation artifact
   - Prompt: `Based on the generated Starter Pack, create a 5-slide presentation about personal AI workflow basics.`
   - Pass: Codex uses a presentation tool if available, or creates a Markdown deck with exactly 5 usable slides, each with a title and body.

4. Image artifact
   - Prompt: `Use imagegen to create a course cover image.`
   - Pass: Codex uses image generation and verifies a saved workspace image path, or creates a complete image brief with subject, layout, text, size, and visual style.

5. One-page document
   - Prompt: `Create a one-page project introduction document.`
   - Pass: the result is a complete one-page document with a clear title, audience, value proposition, key points, and next step.

6. Seven-day plan table
   - Prompt: `Create a 7-day content publishing plan table.`
   - Pass: the result has 7 dated rows and includes topic, artifact, and checklist fields that a user can execute directly.

## Failure Signals

- No usable deliverable is produced.
- The response repeatedly says future actions such as "next I will..." without output.
- A missing tool is mentioned without a concrete blocker and fallback artifact.
- The agent claims a tool succeeded but does not provide a verifiable saved artifact path.
