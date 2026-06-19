# Artifact Smoke Tests

Use these tests when changing the onboarding Skill behavior around installation or output generation. Run them from clean temporary directories and do not commit generated artifacts.

## Setup

Use a clean temporary home when testing plugin installation. Run from the repository root:

```sh
SMOKE_HOME="/tmp/codex-onboarding-home-$(date +%Y%m%d%H%M%S)"
SMOKE_DIR="/tmp/codex-onboarding-smoke-$(date +%Y%m%d%H%M%S)"
mkdir -p "$SMOKE_HOME" "$SMOKE_DIR"
HOME="$SMOKE_HOME" sh scripts/install-codex-onboarding.sh .
```

Run Codex from the smoke directory with the same clean home:

```sh
HOME="$SMOKE_HOME" /Applications/Codex.app/Contents/Resources/codex exec \
  --ephemeral \
  --skip-git-repo-check \
  -C "$SMOKE_DIR" \
  "<prompt>"
```

For zip checks, create a zip from the repo and install from the zip path:

```sh
ZIP_DIR="/tmp/codex-onboarding-zip-$(date +%Y%m%d%H%M%S)"
mkdir -p "$ZIP_DIR"
git archive --format=zip --output="$ZIP_DIR/codex-onboarding-skill.zip" HEAD
HOME="$SMOKE_HOME" sh scripts/install-codex-onboarding.sh "$ZIP_DIR/codex-onboarding-skill.zip"
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
   - Action: install from a GitHub repo, local folder, and zip path in clean Codex homes.
   - Pass: the plugin appears in `codex plugin list`, the install flow asks to start initialization with 3 preference questions, and no `.agents/skills` copy is needed.

2. Existing project initialization
   - Prompt: `Initialize this project with onboarding.`
   - Pass: Codex asks the 3-question initial preference intake unless the user explicitly chooses recommended defaults; a non-technical user can follow the generated Starter Pack draft without extra explanation; existing `AGENTS.md`, `README.md`, `tasks/lessons.md`, and `starter-pack/` are not overwritten.

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
- First initialization generates files before asking the initial preference intake or receiving an explicit "use defaults" instruction.
