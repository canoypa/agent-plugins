# handoff

Writes down where the current session stands, so that an agent without the conversation, such as you coming back later or a new session, can pick up the work.

## What it does

`/handoff:handoff` writes a record of the current state and the next step. If the work is waiting on a decision, the record says what needs deciding and which option is recommended. It also lists corrections you made during the session and the skills to use next, because the next reader cannot see the conversation.

The record keeps only what the next reader would otherwise get wrong or have to ask you again. Anything already written elsewhere, such as ADRs, notes, issues, or commits, is linked by path or URL instead of copied. Unverified points are marked as such, and secrets are redacted. If a record for the same work already exists, its state and next step are updated instead of creating a new record.

Claude does not run this skill on its own. It runs only when you invoke it.

## Usage

```text
/handoff:handoff [--fork] [what to work on next]
```

- With no arguments, it writes the record and stops. Use this to set the work aside and resume it later.
- Text after the command describes what to work on next, and the record is narrowed to it. If the text names only part of the current work, that part is split off into its own record, which states what it covers and where to leave the result. The original record notes the split, and the rest of the work continues in the current session.
- `--fork` also prepares a new session that starts from the record. If a tool for starting sessions is available, such as `spawn_task` in the Claude desktop app, it is used. Otherwise, the skill prints a short prompt to paste into a new session.

```text
/handoff:handoff
/handoff:handoff --fork add length validation to the password field
```

## Where records go

The skill follows your instruction files (such as `CLAUDE.md` or `AGENTS.md`) for where to keep the record. If they say nothing, it asks you each time. To skip the question, add a line such as:

```markdown
Keep handoff records in `docs/worklog/<task>/session.md`.
```

## Limitations

- The record is built from what the current session still has in context. Details dropped by an earlier compaction cannot be recovered.
- A session started with `--fork` reads only the record, not the conversation.
