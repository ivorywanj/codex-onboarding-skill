# Codex Onboarding Skill

`onboarding` is a Codex Skill that helps people from any background create a low-friction Codex Starter Pack for their own work.

It asks short, choice-first questions and generates a small set of project files that help a new AI agent understand the user, find the right files, avoid unsafe actions, and capture future corrections.

It is designed for general use: individuals, teams, learners, professionals, or anyone who wants an AI agent to understand their working context faster.

## What It Generates

The Skill creates a `starter-pack/` folder with:

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

## Why Use It

Most people start every agent session by re-explaining the same background:

- who they are
- what they are working on
- where files live
- what the agent should not touch
- how they want the agent to communicate

This Skill turns that repeated setup into a reusable Starter Pack.

## Install And Initialize

### Easiest Path

Send this to Codex:

```text
Install this onboarding plugin and initialize my current project: https://github.com/ivorywanj/codex-onboarding-skill
```

Codex should install the plugin, verify that it is enabled, and ask:

```text
已装好。要我现在帮你把这个项目初始化成 Codex Starter Pack 吗？
```

Default behavior is to initialize the current project by generating a reviewable `starter-pack/` draft. Existing project files are not overwritten.

### Supported Install Sources

Codex should support:

- GitHub repo or URL: `ivorywanj/codex-onboarding-skill`
- Zip file path: unzip to `/tmp/codex-onboarding-install-*`, find the marketplace manifest, and install from the extracted root
- Local extracted folder path

For exact install commands, see `INSTALL.md`.

### Terminal Install

If you are already inside this repository or an extracted zip, run:

```sh
sh scripts/install-codex-onboarding.sh
```

To install a PR branch directly:

```sh
sh scripts/install-codex-onboarding.sh ivorywanj/codex-onboarding-skill --ref codex/fix-onboarding-artifact-loop
```

Current Codex plugin manifests support plugin descriptions and starter prompts, but not a plugin-defined post-install app popup. The installer and Codex conversation handle the post-install initialization prompt.

### Compatibility: Manual Skill Copy

Copy this folder into the root of the Codex project you want to test:

```text
.agents/skills/onboarding/
```

Your project should look like:

```text
your-project/
└── .agents/
    └── skills/
        └── onboarding/
            ├── SKILL.md
            ├── agents/
            │   └── openai.yaml
            └── references/
                ├── question-bank.md
                ├── starter-pack-spec.md
                └── validation.md
```

Then open a fresh Codex session in that project and run:

```text
Use $onboarding to generate a Codex Starter Pack for my work.
```

If the Skill does not auto-trigger, run:

```text
Read .agents/skills/onboarding/SKILL.md and use it to generate a Codex Starter Pack for my work.
```

## Design Principles

- Choice-first questions.
- At most 3 questions per turn.
- Recommended defaults for every choice question.
- Short text only for names, paths, or special rules.
- Profession-neutral defaults.
- No API keys, passwords, tokens, customer data, or private credentials.
- Semi-automatic import: generate files and instructions, do not modify global machine config.

## Four Memory Layers

The generated Starter Pack helps establish four practical memory layers:

1. Personal memory: who the user is and how they like to work.
2. Project memory: what the project is and where files live.
3. Workflow memory: recurring tasks and how to run them.
4. Correction memory: user corrections that should become future rules.

## Troubleshooting

### The agent keeps saying "next I will..." but does not produce a file

This is usually not a network issue. It normally means the agent is stuck between planning and artifact creation, or the requested tool is unavailable in the current environment.

The generated Starter Pack now tells the agent to handle artifact requests in one of three ways:

- create the requested file or content
- call an available tool such as `presentations` or `imagegen` and verify a saved output path
- state the concrete blocker once and create a fallback artifact, such as a Markdown deck, image brief, prompt, outline, or table

If a tool appears to run but no saved file can be found or verified in the workspace, the agent should not claim the task is complete. It should create a fallback artifact and explain that the tool output could not be verified.

If you are updating from an older Starter Pack, regenerate it with the latest Skill or copy the `Tool And Artifact Tasks` section from the generated `AGENTS.md` into your existing project instructions.

## Safety

Review generated files before sharing or committing them.

Do not put secrets, credentials, customer data, private tokens, private keys, or private company information into generated Starter Packs.

## License

MIT
