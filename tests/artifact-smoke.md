# Artifact Smoke Tests

Use these tests when changing the onboarding Skill behavior around output generation. Run them from clean temporary directories and do not commit generated artifacts.

## Setup

```sh
SMOKE_DIR="/tmp/codex-onboarding-smoke-$(date +%Y%m%d%H%M%S)"
mkdir -p "$SMOKE_DIR/.agents/skills"
cp -R ".agents/skills/onboarding" "$SMOKE_DIR/.agents/skills/onboarding"
```

Run Codex from the smoke directory:

```sh
/Applications/Codex.app/Contents/Resources/codex exec \
  --ephemeral \
  --skip-git-repo-check \
  -C "$SMOKE_DIR" \
  "<prompt>"
```

## Required Cases

1. Starter Pack cold start
   - Prompt: `Use $onboarding with defaults to generate a Codex Starter Pack for a new user.`
   - Pass: the generated Starter Pack contains `AGENTS.md`, `profile.md`, `routes.md`, `tasks/lessons.md`, `skills/README.md`, and `README.md`; `AGENTS.md` includes `Tool And Artifact Tasks`.

2. Presentation artifact
   - Prompt: `Based on the generated Starter Pack, create a 5-slide presentation about personal AI workflow basics.`
   - Pass: Codex uses a presentation tool if available, or creates a Markdown deck such as `deck.md` or `slides.md` with 5 slides.

3. Image artifact
   - Prompt: `Use imagegen to create a course cover image.`
   - Pass: Codex uses image generation and verifies a saved workspace image path, or creates `cover-brief.md` with subject, layout, text, size, and visual style.

4. One-page document
   - Prompt: `Create a one-page project introduction document.`
   - Pass: Codex creates a complete Markdown document file.

5. Seven-day plan table
   - Prompt: `Create a 7-day content publishing plan table.`
   - Pass: Codex creates a file with date, topic, artifact, and checklist columns.

## Failure Signals

- No output file is created.
- The response repeatedly says future actions such as "next I will..." without output.
- A missing tool is mentioned without a concrete blocker and fallback artifact.
- The agent claims a tool succeeded but does not provide a verifiable saved artifact path.
