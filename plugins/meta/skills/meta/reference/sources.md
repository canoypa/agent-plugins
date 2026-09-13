# 公式ドキュメントの参照先

確かめたいことごとに、どのページを見ればよいかをまとめた。ここにないページは、各クライアントのページ一覧（llms.txt）から探す。

## ページ一覧

- Claude Code: https://code.claude.com/docs/llms.txt
- Claude Platform（プロンプティング、モデル別ガイド、Agent Skills）: https://platform.claude.com/llms.txt
- ChatGPT / Codex: https://learn.chatgpt.com/docs/llms.txt
- OpenAI for developers（モデルごとのプロンプトガイド、skills や AGENTS.md の書き方の記事）: https://developers.openai.com/llms.txt
- VS Code: https://code.visualstudio.com/llms.txt
- GitHub Docs（Copilot）: https://docs.github.com/llms.txt

## 複数のクライアントに共通の仕様

- AGENTS.md: https://agents.md
- Agent Skills: https://agentskills.io/specification
- Agent Skills をクライアントに実装する方法（skill をモデルにどう見せるか）: https://agentskills.io/client-implementation/adding-skills-support
- Agent Skills のチェックツール: https://github.com/agentskills/agentskills
- Agent Plugins: https://github.com/agentplugins/agent-plugins-spec

## 症状から原因を探す、読み込まれた指示を確かめる

- Claude Code
  - 症状と原因の対応表、原因を絞り込む進め方: https://code.claude.com/docs/en/debug-your-config
  - 確認用のコマンド: https://code.claude.com/docs/en/commands
  - 指示ファイルが読み込まれたことを記録する hook（InstructionsLoaded）: https://code.claude.com/docs/en/hooks
- Codex
  - ログとセッションの記録: https://learn.chatgpt.com/docs/reference/troubleshooting
- Copilot
  - 送られたプロンプトとログ（VS Code）: https://code.visualstudio.com/docs/agents/agent-troubleshooting/chat-debug-view
  - トラブルシューティング（VS Code）: https://code.visualstudio.com/docs/agents/agent-troubleshooting/troubleshooting

## どこに置くと、いつ何が読まれるか

- Claude Code
  - CLAUDE.md・rules・auto memory: https://code.claude.com/docs/en/memory
  - skills: https://code.claude.com/docs/en/skills
  - subagents: https://code.claude.com/docs/en/sub-agents
  - hooks: https://code.claude.com/docs/en/hooks
  - output styles: https://code.claude.com/docs/en/output-styles
  - plugins: https://code.claude.com/docs/en/plugins-reference
  - セッション中のコンテキストの構成と compaction: https://code.claude.com/docs/en/context-window
- Codex
  - AGENTS.md: https://learn.chatgpt.com/docs/agent-configuration/agents-md
  - skills: https://learn.chatgpt.com/docs/build-skills
  - subagents: https://learn.chatgpt.com/docs/agent-configuration/subagents
  - rules: https://learn.chatgpt.com/docs/agent-configuration/rules
  - hooks: https://learn.chatgpt.com/docs/hooks
  - memories: https://learn.chatgpt.com/docs/customization/memories
  - plugins: https://learn.chatgpt.com/docs/plugins
- Copilot
  - 全体像: https://code.visualstudio.com/docs/agent-customization/overview
  - instructions（VS Code）: https://code.visualstudio.com/docs/agent-customization/custom-instructions
  - skills（VS Code）: https://code.visualstudio.com/docs/agent-customization/agent-skills
  - custom agents（VS Code）: https://code.visualstudio.com/docs/agent-customization/custom-agents
  - hooks（VS Code）: https://code.visualstudio.com/docs/agent-customization/hooks
  - plugins（VS Code）: https://code.visualstudio.com/docs/agent-customization/agent-plugins
  - 種類 × 画面の対応表: https://docs.github.com/en/copilot/reference/custom-instructions-support
  - 機能 × IDE の対応表: https://docs.github.com/en/copilot/reference/customization-cheat-sheet
  - Copilot CLI の instructions: https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-custom-instructions
  - Copilot CLI の plugins: https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-plugin-reference

## 複数の指示がどう組み合わさるか

- Claude Code
  - 機能ごとの重なり方: https://code.claude.com/docs/en/features-overview
  - settings の優先順位: https://code.claude.com/docs/en/settings
  - CLAUDE.md 同士の矛盾: https://code.claude.com/docs/en/memory
- Codex
  - AGENTS.md の連結: https://learn.chatgpt.com/docs/agent-configuration/agents-md
  - config のレイヤー: https://learn.chatgpt.com/docs/config-file/config-advanced
- Copilot
  - GitHub.com の優先順位: https://docs.github.com/en/copilot/concepts/prompting/response-customization
  - VS Code の優先順位: https://code.visualstudio.com/docs/agent-customization/custom-instructions
  - Copilot CLI: https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-custom-instructions

## 書き方

- Claude
  - プロンプトの書き方全般（モデルごとのガイドへのリンクもある）: https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices
  - skill の書き方: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices
  - CLAUDE.md の書き方と機能の使い分け: https://code.claude.com/docs/en/best-practices
  - コンテキストエンジニアリング: https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
- Codex: https://learn.chatgpt.com/docs/prompting
- Copilot
  - instructions の書き方: https://docs.github.com/en/copilot/concepts/prompting/response-customization
  - code review 向け: https://docs.github.com/en/copilot/tutorials/customize-code-review

## 試す、評価する

- Claude Code
  - skill が使われるか、出力が期待どおりかの評価: https://code.claude.com/docs/en/plugin-evals
  - skill の評価と使用状況: https://code.claude.com/docs/en/skills
  - plugin の構文チェック: https://code.claude.com/docs/en/plugins-reference
- skill を書く前に評価を用意する手順: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices

## セッションを振り返る

- Claude Code
  - セッションの保存とエクスポート: https://code.claude.com/docs/en/sessions
  - 複数セッションの分析（/insights）: https://code.claude.com/docs/en/commands
- Codex: https://learn.chatgpt.com/docs/reference/troubleshooting
