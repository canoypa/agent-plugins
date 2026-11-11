# handoff

Hands work over to a session that has not seen the conversation, through a written record.

## What it does

`/handoff:handoff` writes a record from what the current session knows, then hands the work over in one of two ways.

- Followed by a piece of work, it delegates that piece to a new session. The current session keeps the rest.
- With `--clear`, it clears the current session's conversation, and the same work continues from the record with a clean context.

In both cases the reader has only the record, so the record is written to stand on its own. Your requests, decisions, and corrections stay close to your own words, and the agent's explanations are condensed. What was verified is kept apart from what was only inferred. Anything already written elsewhere, such as ADRs, notes, issues, or commits, is linked by path or URL instead of copied. Secrets are redacted. If a record for the same work already exists, it is updated instead of creating a new one.

The session that receives the record is told that the previous agent wrote it, and is asked to tell you its understanding of the goal, the current state, and the next step before doing any of the work. It starts once you confirm.

Claude does not run this skill on its own. It runs only when you invoke it.

## Usage

```text
/handoff:handoff <work to hand off>
/handoff:handoff --clear [what to work on next]
```

```text
/handoff:handoff add length validation to the password field
/handoff:handoff --clear
/handoff:handoff --clear start the implementation
```

### Delegating a piece of work

The piece gets its own record, written as a brief: the purpose and how it serves the current goal, what done looks like, what to report back, what is in scope, the files involved, what is already decided, and what is unverified. The new session starts from that record only, without this conversation, and runs under the current session. This is a separate session, not a subagent.

### `--clear`

The record covers the whole of the current work: its state, the goal and what done looks like, what you asked for and corrected, what is left to do, likely forks and what to do at each, and the approaches that were ruled out and why. Text after `--clear` is recorded, in your words, as what to work on next.

After the conversation is cleared, send any message, such as "continue". A hook tells the session where the record is when that first message arrives.

Use `--clear` when the conversation itself is in the way, for example after a plan is settled and the build should start clean, or after repeated corrections have not fixed a misunderstanding. If the session has only grown long, `/compact` keeps the work going without writing a record.

### Where the session tools are missing

Both forms use the session tools of the Claude desktop app. Where those tools are not available, the skill writes the record and says that the handover cannot run there.

## Where records go

The skill follows your instruction files (such as `CLAUDE.md` or `AGENTS.md`) for where to keep the record. If they say nothing, it asks you each time. To skip the question, add a line such as:

```markdown
Keep handoff records in `docs/worklog/<task>/session.md`.
```

## Limitations

- The record is built from what the current session still has in context. Details dropped by an earlier compaction cannot be recovered.
- The record is written by the session being handed over from. If that session has misunderstood the work, the record can carry the misunderstanding. Your own words in the record, and the receiving session's summary of its understanding, are there so that you can catch it.
- After a handover, the next reader has only the record, not the conversation.
