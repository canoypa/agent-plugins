# NEVER UNSIGNED COMMIT

Rejects pushes that contain unsigned commits.

## What it does

- A global Git `pre-push` hook checks commits you are about to push that are not yet on a remote and were committed by you. If any of them is unsigned, the push is rejected.
- Inside Claude Code, a `PreToolUse` hook denies commands that would bypass the check: using `--no-gpg-sign`, disabling `commit.gpgsign`, running `git push --no-verify`, modifying `hook.never-unsigned-commit.*` or `hook.pre-push.enabled`, and replacing the global Git config.

The `pre-push` hook checks that a signature (the `gpgsig` header) is present. It does not verify the signature, because verification requires each signer's key.

## Setup

```text
/never-unsigned-commit:setup
```

This copies the hook to `~/.config/git/hooks/never-unsigned-commit/` and registers it in `~/.gitconfig` as `hook.never-unsigned-commit`, so it runs in every repository alongside the repository's own hooks. Run the setup once per machine, and again after updating the plugin. `/never-unsigned-commit:setup --uninstall` removes the hook.

Requires Git with support for config-based hooks (`hook.<name>.command`) and Perl, with commit signing already configured (`commit.gpgsign = true`, `user.signingkey`).

## Limitations

- A user in a terminal can still push with `git push --no-verify`.
- To require signed commits server-side, use a GitHub ruleset.
