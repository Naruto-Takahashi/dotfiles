## 共通ルール
- **句読点の厳守**: 日本語の句読点は必ず全角の「，」（カンマ）と「．」（ピリオド）を使用してください．「、」や「。」は使用しないでください．
- 日本語でやり取りしてください．
- 最初にタスクを実行する計画を作成し，ユーザーの許可を得てから進行してください．
- タスクを完遂するために追加で必要な情報がある場合，ユーザーに質問してください．
- 重要な技術的決定をする場合，簡潔に提示し，ユーザーからのフィードバックを得てください．

---
## Dotfiles 運用ルール
- **OS環境**: Ubuntu 24.04 (WSL2) / Windows (ユーザー: tnaru)
- **管理ディレクトリ**: `~/dotfiles` (実体は `~/ghq/github.com/Naruto-Takahashi/dotfiles` に配置し，シンボリックリンクを作成)．
- **設定ファイル実体**:
    - `~/.zshrc` -> `~/dotfiles/.zshrc`
    - `~/.config/nvim` -> `~/dotfiles/nvim`
    - `~/.config/lazygit/config.yml` -> `~/dotfiles/lazygit/config.yml`
    - `~/.local/bin/*` (自作ツール) -> `~/dotfiles/bin/*`
- **編集ルール**: 設定を変更する際は，必ず実体ディレクトリ（ghq配下）側のファイルを編集し，変更後はGitでコミット・プッシュすること．
- **Windows連携**: WezTerm，AutoHotkey，GlazeWM 等のWindowsアプリの設定は，WSL側からWindows側の所定のディレクトリへ**コピー**して配置する．
    - パス解決のトラブルを避けるため，Windows側からWSL側へのシンボリックリンクは使用しない．
    - 設定変更後は `.zshrc` に定義された `sync-win` コマンドを実行してWindows側に反映させること．
- **Neovim構成**: `lazy.nvim` によるプラグイン管理，`snacks.nvim` によるUI拡張．詳細は `~/dotfiles/nvim/KEYBINDINGS.md` を参照．
- **機密情報**: APIキー等は `~/.env` で管理し，Gitには絶対にコミットしないこと．

---
## リポジトリ管理・開発環境ルール (ghq + Go)
- **Go環境**: `/usr/local/go` (v1.23.4) を利用。GOPATHはデフォルト (`~/go`)。
- **リポジトリ管理**: **ghq** (`~/.local/bin/ghq`) を使用し、すべてのリポジトリを `~/ghq` 配下で一元管理する。
    - **ルートディレクトリ**: `~/ghq` (例: `~/ghq/github.com/user/repo`)
    - **運用フロー**:
        1.  新規プロジェクトは `ghq create project-name` で作成、またはGitHub作成後に `ghq get` で取得する。
        2.  `~/projects` などの別ディレクトリに実体を置かず、すべて `ghq` 管理下に統一する（既存の `~/projects` 内の一部は `~/ghq` へのシンボリックリンクとして残存）。
        3.  移動は `Ctrl+g` (fzf連携) または Neovim内の `<Leader>fq` (Telescope連携) を使用し、パスを意識せずに検索して移動する。

---
## 開発指針 (CLIツール・スクリプト)
- **高速性重視**: Node.jsやPythonランタイムの起動オーバーヘッドを避けるため、可能な限り **Shell Script + curl** で実装する。
- **JSON処理**: 安全かつ高速な処理のために **jq** を使用する。
- **UI/UX**: ユーザー対話には **gum** (Charm) を使用し、リッチで直感的なUIを提供する。
- **AI連携**: Gemini API (Flashモデル) を `curl` で直接叩く構成を推奨する。

---
## クリップボード画像連携 (\cコマンド)
- ユーザーが `/c` コマンドを実行し，出力に "Image captured." が含まれていた場合，あなたは**直ちに** `read_file`
ツールを使用して，コマンド内で指定された画像パス（通常は `.gemini/tmp/clipboard_image.png`）を読み込んでください．
- ユーザーからの `/v` コマンド（画像読み込み指示）を待つ必要はありません．能動的に画像を読み込み，その内容を把握してください．
- 読み込み後は，「画像を確認しました」等の短い応答を返し，ユーザーの質問を待ってください．

---
## トラブルシューティング・ナレッジ
### nvim-treesitter
- **現象**: `module 'nvim-treesitter.configs' not found` エラーが発生し，ハイライトが無効になる．
- **原因**: `nvim-treesitter` の `main` ブランチで大規模なリファクタリングが行われ，後方互換性が失われた（`configs` モジュール削除）ため．
- **解決策**: プラグイン設定でブランチを `master` (安定版/レガシー) に固定する．
    ```lua
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "master", -- mainブランチは破壊的変更が含まれるためmasterに固定
      build = ":TSUpdate",
      -- ...
    }
    ```

## Gemini Added Memories
- WSL distribution name is 'Ubuntu', not 'Ubuntu-24.04'.
- WezTerm config path on Windows is C:\Users\tnaru\.config\wezterm\wezterm.lua
- WezTerm config files are copied from WSL to Windows, not symlinked.
