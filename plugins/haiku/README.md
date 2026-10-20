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

After a shell command that mentions `review`, the plugin tells the agent how to add the haiku. If the command submitted a review, the agent runs `append-haiku` with the review's URL, so a review gets a haiku whichever command posted it: `gh pr review`, `gh api`, a GraphQL mutation, or a `gh` extension. Only a review you submitted in the last 10 minutes gets one.

Requires Claude Code, the `claude` CLI, `gh`, and Perl.
