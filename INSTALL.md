# Install And Initialize

This file is for Codex agents helping a user install the onboarding plugin from a GitHub link, zip file, or local folder.

## User-Friendly Request

The user should be able to say one sentence:

```text
Install this onboarding plugin and initialize my current project: https://github.com/ivorywanj/codex-onboarding-skill
```

Do not ask the user to manually copy `.agents/skills`, paste `$onboarding` into a new session, or inspect plugin internals.

## Install Sources

### GitHub Repo Or URL

```sh
codex plugin marketplace add ivorywanj/codex-onboarding-skill --ref main
codex plugin add codex-onboarding-skill@codex-onboarding
codex plugin list
```

For a PR branch, replace `main` with the branch name.

### Zip Path

If the user gives a `.zip` path:

1. Unzip it into `/tmp/codex-onboarding-install-*`.
2. Find the extracted directory containing `.agents/plugins/marketplace.json` or `.codex-plugin/marketplace.json`.
3. Install from that extracted directory:

```sh
codex plugin marketplace add /tmp/codex-onboarding-install-*/<extracted-root>
codex plugin add codex-onboarding-skill@codex-onboarding
codex plugin list
```

Do not copy zip contents into the user's project.

### Local Extracted Folder

```sh
codex plugin marketplace add /path/to/codex-onboarding-skill
codex plugin add codex-onboarding-skill@codex-onboarding
codex plugin list
```

## After Install

After `codex plugin list` shows the plugin installed and enabled, ask:

```text
已装好。要我现在帮你把这个项目初始化成 Codex Starter Pack 吗？
```

Default to initializing the current project. If the user wants another project, ask for one project path. If the user says no, stop and say they can later ask: `帮我初始化 onboarding`。

## Existing Project Rules

- Prefer the current workspace if it looks like a project.
- Generate a draft under `starter-pack/`.
- If `starter-pack/` already exists, use `starter-pack-draft-YYYYMMDD-HHMM/`.
- Do not overwrite existing `AGENTS.md`, `README.md`, or `tasks/lessons.md`.
- Read only lightweight context such as top-level files, `README*`, existing `AGENTS.md`, and obvious docs folders.
- Do not read `.env*`, private keys, credentials, caches, build artifacts, or large generated folders.
