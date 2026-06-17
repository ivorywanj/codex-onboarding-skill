# Release Checklist

Before publishing this repository:

- Run a privacy scan for personal names, local paths, project names, and platform-specific private context.
- Run a secret scan for API keys, passwords, private keys, tokens, `.env*`, and database URLs.
- Confirm `SKILL.md` frontmatter uses `name: onboarding`.
- Confirm `agents/openai.yaml` uses `$onboarding`.
- Open a fresh Codex session and test:

```text
Use $onboarding to generate a Codex Starter Pack for my work.
```

- Confirm the Skill asks choice-first questions and creates the requested Starter Pack files.
