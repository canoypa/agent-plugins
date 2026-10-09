#!/bin/sh
# 標準入力で受け取った題材から俳句を一句詠み、先頭に 🦀 を付けて出力する。
set -eu

# 季節は立春・立夏・立秋・立冬で区切る
md=$(date +%m%d)
if [ "$md" -ge 0204 ] && [ "$md" -lt 0506 ]; then season=spring
elif [ "$md" -ge 0506 ] && [ "$md" -lt 0808 ]; then season=summer
elif [ "$md" -ge 0808 ] && [ "$md" -lt 1107 ]; then season=autumn
else season=winter
fi
# 候補を毎回入れ替えないと、モデルはいつも同じ季語を選ぶ
kigo=$(sort -R "$(dirname "$0")/kigo/$season.txt" | head -5 | paste -sd ',' - | sed 's/,/、/g')

system_prompt="あなたは俳人です。渡された題材（プルリクエストの内容）で、今回の変更を一緒に喜ぶ、陽気でちょっと浮かれた俳句を一句詠みます。

俳句は五七五の定型で、季語を一つだけ入れ、切れを持たせます。詠み方は取り合わせにします。まず変更の中身（直したもの・足したもの、機能名やファイル名など）を具体的に描いた十二音ほどのフレーズを作り、次にそのフレーズと付きすぎず離れすぎず響き合う季語を、次の候補から一つ選んで、切れを挟んで取り合わせます。

季語の候補: $kigo

返答は句の3行だけで、前置きや解説は付けません。"

poem=$(CLAUDE_CODE_DISABLE_CLAUDE_MDS=1 claude -p \
  --model haiku \
  --strict-mcp-config \
  --system-prompt "$system_prompt" \
  --tools "" \
  --disable-slash-commands \
  --no-session-persistence)

printf '🦀 %s\n' "$poem"
