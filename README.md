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

## Install

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

## Safety

Review generated files before sharing or committing them.

Do not put secrets, credentials, customer data, private tokens, private keys, or private company information into generated Starter Packs.

## License

MIT
