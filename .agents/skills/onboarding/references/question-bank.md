# Question Bank

Use these questions in batches of at most 3. Prefer choices. Defaults are marked `Recommended`.

## Batch 1: User And Goal

1. What best describes you?
   - Individual professional (Recommended)
   - Student or learner
   - Writing or communication user
   - Team member or operator

2. What should the agent help with first?
   - General work projects (Recommended)
   - Writing or communication
   - Research or learning
   - Planning or personal admin

3. What tone should the agent use?
   - Concise and direct (Recommended)
   - Step-by-step teaching
   - Strategic sparring partner

## Batch 2: Work Surface

1. What type of workspace is this?
   - Existing project in the current workspace (Recommended)
   - General work folder
   - Notes or knowledge base
   - Project or code workspace
   - New empty workspace

2. What should be protected?
   - Secrets and env files (Recommended)
   - Human-maintained input folders
   - Final or published work
   - External actions such as sending, publishing, deploying, or deleting

3. What should the agent do when unsure?
   - Ask before acting (Recommended)
   - Make a safe draft
   - Only inspect files and report

## Batch 3: Route Readiness

1. Do you already know the key folder paths?
   - Use the current workspace layout (Recommended)
   - Not yet, use placeholders with examples
   - Yes, I will provide short paths now

If the user chooses the current workspace layout, inspect only lightweight project context and write visible top-level paths into `routes.md`; use `TBD` for anything unclear.

If the user chooses placeholders, set route values to `TBD` and include examples in `routes.md`.

If the user chooses to provide paths, ask for short text only:

1. Main work or project folder path.
   - Example: `work/`, `project/`, `notes/`

2. Where source material lives.
   - Example: `inputs/`, `raw/`, `research/`

3. Where generated output should go.
   - Example: `outputs/`, `drafts/`, `reports/`

## Batch 4: Repeated Workflows

Use multi-select:

- Turn a rough idea into a clear outline (Recommended)
- Summarize notes into action items
- Review AI output quality
- Audit context/token waste
- Find the right files before starting
- Turn corrections into reusable rules
- Prepare a plan for a project or task
- Inspect a workspace before making changes

## Batch 5: Custom Rules

Ask only if needed:

1. Any special forbidden action? Keep it to one short sentence.
   - Example: "Never publish or send messages without approval."

2. Any folder the agent must never edit?
   - Example: `inputs/`, `raw/`, `.env*`

3. Any recurring phrase or preference?
   - Example: "Put conclusion first."

## Completion Rule

Enough information exists when the agent knows:

- who the user is
- what kind of work they do
- where source files and outputs live, or that they are TBD
- what safety boundaries apply
- which 4 starter workflows to recommend
