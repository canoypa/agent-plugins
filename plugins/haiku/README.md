# haiku

Claude Haiku writes a "haiku" for every review you submit. 🦀

## What it does

When your agent posts a pull request review for you, a haiku about the change is added to the end of the review:

```markdown
LGTM

<!-- haiku_footer_start -->
**Haiku**
<sub>🦀 整形と Lint も型も鰯雲</sub>
<!-- haiku_footer_end -->
```

Claude Haiku writes the haiku from the pull request's title, description, and diff. It uses a seasonal word that matches today's date.

## How it works

When your agent runs a shell command that mentions `review`, the plugin tells the agent how to add a haiku. If the command submitted a review, the agent runs `append-haiku` with the review's URL.

Any command that submits a review works, such as `gh pr review`, `gh api`, or a `gh` extension.

Only your own review gets a haiku, and only within 10 minutes after you submit it.

Requires the `claude` CLI, `gh`, and Perl.
