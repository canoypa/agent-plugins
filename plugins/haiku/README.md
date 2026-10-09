# haiku

Claude Haiku writes a "haiku" for every review you submit. 🦀

## What it does

When your agent posts a pull request review for you, a haiku about the change is added to the end of the review:

```markdown
LGTM

## Haiku

🦀 整形と
lintも型も
鰯雲
```

Claude Haiku writes the haiku from the pull request's title, description, and diff. It uses a seasonal word that matches today's date.

Reviews posted with `gh pr review`, or with `gh api` to a pull request's `reviews` endpoint, get a haiku.

## Other review commands

If you post reviews with another command, such as a `gh` extension, add it to the plugin's `review_commands` option:

```text
gh my-extension reviews create
```

The command must contain `review` and print the URL of the review it posted. This option is available only in Claude Code; in other clients that run plugin hooks, only `gh pr review` and `gh api` are covered.

Requires the `claude` CLI, `gh`, and Perl.
