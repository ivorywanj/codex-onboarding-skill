# Release Checklist

Before publishing this repository:

- Run a privacy scan for personal names, local paths, project names, and platform-specific private context.
- Run a secret scan for API keys, passwords, private keys, tokens, `.env*`, and database URLs.
- Confirm `.codex-plugin/marketplace.json` exposes `codex-onboarding`.
- Confirm `plugins/codex-onboarding-skill/.codex-plugin/plugin.json` exposes `codex-onboarding-skill`.
- Confirm `SKILL.md` frontmatter uses `name: onboarding`.
- Confirm `agents/openai.yaml` uses `$onboarding`.
- Install from a clean Codex environment and test:

```sh
codex plugin marketplace add ivorywanj/codex-onboarding-skill --ref main && \
codex plugin add codex-onboarding-skill@codex-onboarding && \
printf '\nCodex Onboarding is installed.\nNext: open a new Codex session and send:\nUse $onboarding to generate a Codex Starter Pack for my work.\n'
```

- Confirm the install command prints the next-step message after successful installation.
- Open a fresh Codex session and test:

```text
Use $onboarding to generate a Codex Starter Pack for my work.
```

- Confirm the Skill asks choice-first questions and creates a usable Starter Pack with artifact-task rules.
