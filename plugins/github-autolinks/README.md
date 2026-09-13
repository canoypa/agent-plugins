# github-autolinks

Warns when a commit message, issue, or pull request would create mentions or issue references on GitHub that you may not intend.

## What it does

- A global Git `commit-msg` hook prints a warning when a commit message creates links on GitHub. The commit still goes through.
- Inside Claude Code, a `PreToolUse` hook checks text before it is posted with `gh` (`issue create`, `issue edit`, `issue comment`, `pr create`, `pr edit`, `pr comment`, `pr review`, `pr merge`, and `gh api` requests) or with a GitHub MCP tool. If the text creates links, the call is denied once and the findings are shown to the agent. The agent can then fix the text, or repeat the same call to post it as is.

## What it detects

- Mentions: `@user`, `@org`
- References: `#123`, `GH-123`, `owner/repo#123`, and URLs of issues, pull requests, and discussions
- Closing keywords followed by a reference, such as `closes #123`

Email addresses and scoped package names such as `@types/node` are not flagged.

Commit messages and Markdown text are checked differently:

- In a commit message, backticks do not stop references or closing keywords.
- In issue and pull request text, code spans and code blocks are skipped. Pull request text is also checked as a commit message, because a squash merge can turn it into one. Findings that apply only to squash merges are marked `(squash merge)`.

## Setup

```text
/github-autolinks:setup
```

This copies the `commit-msg` hook to `~/.config/git/hooks/github-autolinks/` and registers it in `~/.gitconfig` as `hook.github-autolinks`, so it runs in every repository alongside the repository's own hooks. Run the setup once per machine, and again after updating the plugin. `/github-autolinks:setup --uninstall` removes the hook.

The `PreToolUse` hook needs no setup. It works once the plugin is enabled.

Requires Git with support for config-based hooks (`hook.<name>.command`) and Perl.

## Limitations

- Detection uses patterns, not GitHub itself, so it can miss links that GitHub creates or flag text that GitHub ignores.
- The `PreToolUse` hook reads text from the `gh` command line, from files passed with `--body-file`, `--input`, or `-F`, and from heredocs. Text passed in other ways may not be checked.
- Text posted outside Claude Code, such as from the GitHub web interface, is not checked.
