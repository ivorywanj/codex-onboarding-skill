# Release Checklist

Before publishing this repository:

- Run a privacy scan for personal names, local paths, project names, and platform-specific private context.
- Run a secret scan for API keys, passwords, private keys, tokens, `.env*`, and database URLs.
- Confirm `.codex-plugin/marketplace.json` exposes `codex-onboarding`.
- Confirm `plugins/codex-onboarding-skill/.codex-plugin/plugin.json` exposes `codex-onboarding-skill`.
- Confirm `SKILL.md` frontmatter uses `name: onboarding`.
- Confirm `agents/openai.yaml` uses `$onboarding`.
- Install from a clean Codex environment and test GitHub, local folder, and zip sources:

```sh
sh scripts/install-codex-onboarding.sh ivorywanj/codex-onboarding-skill --ref main
```

- Confirm the install workflow asks whether to initialize the current project after successful installation.
- In the same conversation or a fresh Codex session, test:

```text
Initialize this project with onboarding.
```

- Confirm the Skill asks choice-first questions, creates a usable Starter Pack draft, and does not overwrite existing project files.
