#!/usr/bin/env bash
set -uo pipefail
shopt -s nullglob
cd "$(dirname "$0")/.."

schema="https://agent-plugins.org/schemas/1.0.0/plugin.schema.json"
marketplace=".claude-plugin/marketplace.json"
status=0

fail() {
  echo "error: $1" >&2
  status=1
}

claude plugin validate . || status=1

for dir in plugins/*/; do
  name=$(basename "$dir")
  manifest="plugins/$name/plugin.json"

  if [[ -L "$manifest" || ! -f "$manifest" ]]; then
    fail "$manifest must be a regular file"
    continue
  fi
  [[ $(jq -r '."$schema"' "$manifest") == "$schema" ]] || fail "$manifest: \$schema must be $schema"
  [[ $(jq -r '.name' "$manifest") == "$name" ]] || fail "$manifest: name must be $name"
  [[ $(readlink "plugins/$name/.claude-plugin/plugin.json") == "../plugin.json" ]] ||
    fail "plugins/$name/.claude-plugin/plugin.json must be a symlink to ../plugin.json"
  jq -e --arg n "$name" '.plugins[] | select(.name == $n and .source == "./plugins/\($n)")' "$marketplace" >/dev/null ||
    fail "$marketplace must list $name with source ./plugins/$name"

  claude plugin validate "plugins/$name" || status=1
done

exit $status
