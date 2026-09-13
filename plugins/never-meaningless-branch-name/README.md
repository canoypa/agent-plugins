# NEVER MEANINGLESS BRANCH NAME

Rejects pushes to branches whose names match forbidden patterns, such as the default names a coding agent assigns to its branches.

## What it does

- A global Git `pre-push` hook matches each branch you push against the forbidden patterns. On a match, the push is rejected and the reason for that pattern is shown. Branch deletions and tag pushes are not checked.
- Inside Claude Code, a `PreToolUse` hook denies commands that would bypass the check: running `git push --no-verify`, modifying `hook.never-meaningless-branch-name.*` or `hook.pre-push.enabled`, changing the patterns and reasons, and replacing the global Git config.

## Setup

```text
/never-meaningless-branch-name:setup
```

This copies the hook to `~/.config/git/hooks/never-meaningless-branch-name/` and registers it in `~/.gitconfig` as `hook.never-meaningless-branch-name`, so it runs in every repository alongside the repository's own hooks. Run the setup once per machine, and again after updating the plugin. `/never-meaningless-branch-name:setup --uninstall` removes the hook.

Requires Git with support for config-based hooks (`hook.<name>.command`).

## Patterns

By default, branches whose names start with `claude/` are rejected with this reason: "This is the name Claude Code gave by default; choose one on purpose."

To use your own rules instead, give each rule a name, an extended regular expression, and the reason to show when a branch matches:

```sh
git config --global never-meaningless-branch-name.hash.pattern '-[0-9a-f]{6}$'
git config --global never-meaningless-branch-name.hash.reason 'A random hash suffix does not describe the work.'
```

Once any rule is set, the default `claude/` rule no longer applies. Add it as a rule of its own if you still want it. A pattern that is not a valid extended regular expression rejects every push until it is fixed.

## Limitations

- A user in a terminal can still push with `git push --no-verify`.
- If no rule is set globally, adding a rule to a repository's local config turns off the default `claude/` rule in that repository.
