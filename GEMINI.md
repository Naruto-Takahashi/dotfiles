## 共通ルール
- 日本語でやり取りしてください．
- 句点は｢．｣を，読点は｢，｣を使用してください．
- 最初にタスクを実行する計画を作成し，ユーザーの許可を得てから進行してください．
- タスクを完遂するために追加で必要な情報がある場合，ユーザーに質問してください．
- 重要な技術的決定をする場合，簡潔に提示し，ユーザーからのフィードバックを得てください．

---
## Dotfiles 運用ルール
- **OS環境**: Ubuntu 24.04 (WSL2) / Windows (ユーザー: tnaru)
- **管理ディレクトリ**: `/mnt/c/Users/tnaru/dotfiles` (Linux側からは `~/dotfiles` でアクセス)
- **設定ファイル実体**:
    - `~/.zshrc` -> `~/dotfiles/.zshrc`
    - `~/.config/nvim` -> `~/dotfiles/nvim`
- **編集ルール**: 設定を変更する際は、必ず実体ディレクトリ側のファイルを編集し、変更後はGitでコミット・プッシュすること。
- **Neovim構成**: `lazy.nvim` によるプラグイン管理、`snacks.nvim` によるUI拡張。詳細は `~/dotfiles/nvim/KEYBINDINGS.md` を参照。
- **WezTerm構成**: Windows側で動作。設定は `~/dotfiles/wezterm` で管理。詳細は `~/dotfiles/wezterm/KEYBINDINGS.md` を参照。
- **ブラウザ操作**: WSLからブラウザを開く際は `powershell.exe -Command Start-Process 'URL'` を使用すること。
