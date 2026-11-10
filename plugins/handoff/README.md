# handoff

Writes down where the current session stands, so that an agent without the conversation, such as you coming back later or a new session, can pick up the work.

## What it does

`/handoff:handoff` writes a record of the current state and the next step. If the work is waiting on a decision, the record says what needs deciding and which option is recommended. It also lists corrections you made during the session and the skills to use next, because the next reader cannot see the conversation.

The record keeps only what the next reader would otherwise get wrong or have to ask you again. Anything already written elsewhere, such as ADRs, notes, issues, or commits, is linked by path or URL instead of copied. Unverified points are marked as such, and secrets are redacted. If a record for the same work already exists, its state and next step are updated instead of creating a new record.

Claude does not run this skill on its own. It runs only when you invoke it.

## Usage

```text
/handoff:handoff [--clear | --sub <work to hand off>]
```

Every form writes the record first. What happens next depends on the option.

- With no option, it stops. Use this to set the work aside and resume it later, for example when you leave a session open overnight or before `/compact`.
- `--clear` clears the current session's conversation, so the same work continues with a clean context. When the session starts again, a hook tells it where the record is. Send any message, such as "continue", to go on.
- `--sub` hands part of the current work to a new session. That part gets its own record, which states what it covers, and the original record notes the split. The new session starts from that record only, without this conversation, and runs under the current session, which keeps the rest of the work. This is a separate session, not a subagent.

```text
/handoff:handoff
/handoff:handoff --clear
/handoff:handoff --sub add length validation to the password field
```

`--clear` and `--sub` use the session tools of the Claude desktop app. Where those tools are not available, the skill writes the record and says that the option cannot run there.

## Where records go

The skill follows your instruction files (such as `CLAUDE.md` or `AGENTS.md`) for where to keep the record. If they say nothing, it asks you each time. To skip the question, add a line such as:

```markdown
Keep handoff records in `docs/worklog/<task>/session.md`.
```

## Limitations

- The record is built from what the current session still has in context. Details dropped by an earlier compaction cannot be recovered.
- After `--clear` or `--sub`, the next reader has only the record, not the conversation.
