---
name: setup
description: 署名のないコミットの push を拒否する git hook を、ユーザーの全リポジトリに設定する（または解除する）。
disable-model-invocation: true
---

# never-unsigned-commit の設定

`${CLAUDE_SKILL_DIR}/install.sh` を実行して、pre-push hook を `~/.gitconfig` の `hook.never-unsigned-commit` に登録する。解除を頼まれたときは `--uninstall` を付ける。どちらもユーザーのグローバルな git 設定を書き換えるが、このスキルを呼んだこと自体を実行の依頼として扱ってよい。

登録には config-based hooks（`hook.<name>.command`）に対応した git が必要である。スクリプトは登録後に `git hook list pre-push` で確認し、見つからなければ失敗する。失敗したら出力をそのまま伝える。

登録できたら、署名の設定がそろっているかを確認して伝える。`git config --global commit.gpgsign` が `true` で、`user.signingkey` が設定されていなければ、push はすべて失敗する。

この hook は `git push --no-verify` で回避できる。Claude Code の中では同じプラグインの hook がその操作を拒否するが、人が端末で回避することは防げない。リポジトリ側で必ず強制するには、GitHub の ruleset で署名を必須にする。
