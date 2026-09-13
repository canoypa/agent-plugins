---
name: setup
description: コミットメッセージが GitHub 上でメンションや issue 参照になるときに警告する git hook を、ユーザーの全リポジトリに設定（または解除）する。
disable-model-invocation: true
---

# github-autolinks の設定

`${CLAUDE_SKILL_DIR}/install.sh` を実行して、commit-msg hook を `~/.gitconfig` の `hook.github-autolinks` に登録する。解除を依頼されたときは `--uninstall` を付ける。どちらもユーザーのグローバルな git 設定を書き換えるが、このスキルを呼んだこと自体を実行の依頼として扱ってよい。

登録には config-based hooks（`hook.<name>.command`）に対応した git が必要である。スクリプトは登録後に `git hook list commit-msg` で確認し、見つからなければ失敗する。失敗したら出力をそのまま伝える。

git hook が対象とするのはコミットメッセージのみで、警告してもコミットは中断しない。issue や pull request の本文とコメントは、同じプラグインの Claude Code hook が投稿前に一度だけ止めて、リンクになる箇所をエージェントに伝える。こちらは設定しなくても、プラグインを有効にした時点で動作する。
