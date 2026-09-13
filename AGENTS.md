# agent-plugins

A public plugin marketplace named `canoypa`. Claude Code is the primary client; plugins also follow the [Agent Plugins specification](https://github.com/agentplugins/agent-plugins-spec) so other clients can load them.

## Layout

```
.claude-plugin/marketplace.json     # lists every plugin
plugins/<name>/
├── plugin.json                     # manifest
├── .claude-plugin/plugin.json      # symlink -> ../plugin.json
└── skills/<skill>/SKILL.md
```

A plugin is installable only once `.claude-plugin/marketplace.json` lists it as `{ "name": "<name>", "description": "…", "source": "./plugins/<name>" }`. Every client that supports marketplaces reads this path, and some show the entry's `description` before install.

## Manifest

`plugins/<name>/plugin.json` is an Agent Plugins 1.0 manifest:

- `$schema` is exactly `https://agent-plugins.org/schemas/1.0.0/plugin.schema.json`. Some clients match it exactly and disable a plugin that declares another schema version.
- Write `$schema`, `name`, and `description` only.
  - Author, license, and repository are the same for every plugin and live at the repository level.
  - Claude-specific fields fall outside the specification, and `extensions` waits until the target client has been tested.
- `name` is kebab-case and equals the directory name.

Claude Code reads only `.claude-plugin/plugin.json`, so that path is a relative symlink to the root manifest. Keep the real file at the root: Codex disables a plugin whose root `plugin.json` is a symlink.

## Components

- Put reusable behavior in `skills/`. Skills are the component every client shares. `commands/` is legacy.
- A skill's frontmatter `name` equals its directory name. `description` is required (up to 1024 characters).
- `agents/` and `hooks/hooks.json` go in Claude Code's default locations and work in Claude Code only.
- Refer to files in the plugin through `${CLAUDE_PLUGIN_ROOT}` (or `${CLAUDE_SKILL_DIR}` inside a skill). Installed plugins are copied to a cache, so paths outside the plugin directory break.

## Copy

- The plugin `description` appears in plugin lists. Write it as UI text: one short sentence, no emoji. Use the same text in `plugin.json` and the marketplace entry.
- A skill's `description` tells the agent when to use the skill. Write it for that purpose.
- This repository is public. Keep private or organization-specific context out of it.

## Check

```sh
scripts/validate.sh
```

It runs `claude plugin validate` on the marketplace and every plugin, then checks what that command can't see: the `$schema` value, the symlink, and the marketplace entry. CI runs the same script.
