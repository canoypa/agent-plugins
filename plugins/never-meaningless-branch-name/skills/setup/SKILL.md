---
name: setup
description: 自動生成されたブランチ名（既定は claude/ で始まるもの）への push を拒否する git hook を、ユーザーの全リポジトリに設定する（または解除する）。
disable-model-invocation: true
argument-hint: "[--uninstall]"
allowed-tools: Bash(sh ${CLAUDE_SKILL_DIR}/scripts/install.sh) Bash(sh ${CLAUDE_SKILL_DIR}/scripts/install.sh *)
---

# never-meaningless-branch-name の設定

`sh ${CLAUDE_SKILL_DIR}/scripts/install.sh $ARGUMENTS` を実行する。引数が無ければ pre-push hook を `~/.gitconfig` の `hook.never-meaningless-branch-name` に登録し、`--uninstall` なら解除する。どちらもユーザーのグローバルな git 設定を書き換えるが、このスキルを呼んだこと自体を実行の依頼として扱ってよい。それ以外の引数ではスクリプトが使い方を表示して失敗するので、その出力を伝える。

登録には config-based hooks（`hook.<name>.command`）に対応した git が必要である。スクリプトは登録後に `git hook list pre-push` で確認し、見つからなければ失敗する。失敗したら出力をそのまま伝える。

拒否する名前は、ルールごとに `never-meaningless-branch-name.<名前>.pattern`（拡張正規表現）と `.reason`（マッチしたときに表示する理由）で設定する。ユーザーがパターンを指定したら、理由も聞いたうえで `git config --global` で両方を設定する。理由は、push を止められた人やエージェントが名前の付け直し方を判断する材料になる。ルールが一つも無ければ、組み込みの `^claude/` を使う。ルールを一つでも設定すると組み込みは使われないので、`^claude/` も残したいなら明示的に追加する。

この hook は `git push --no-verify` や、リポジトリのローカル設定でルールを追加して組み込みの既定を無効化することで回避できる。Claude Code の中では同じプラグインの hook がそれらの操作を拒否するが、人が端末で回避することは防げない。
