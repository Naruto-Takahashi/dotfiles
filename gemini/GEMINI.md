## 共通ルール
- **句読点の厳守**: 日本語の句読点は必ず全角の「，」（カンマ）と「．」（ピリオド）を使用してください．「、」や「。」は使用しないでください．
- 日本語でやり取りしてください．
- **計画の提示方法**: タスクを実行する前に計画を提示し，ユーザーの許可を得てから進行してください．
    - 大掛かりな作業（大規模なリファクタリングやアーキテクチャの変更，不確実性の高い作業など）を除き，計画は `.md`（`implementation_plan.md`）にファイル化せず，チャット上で簡潔にテキスト形式で提示して承諾を得てください．
- タスクを完遂するために追加で必要な情報がある場合，ユーザーに質問してください．
- 重要な技術的決定をする場合，簡潔に提示し，ユーザーからのフィードバックを得てください．

---
## 設定ファイル運用ルール
- **OS環境**: Ubuntu (WSL2) / Windows (ユーザー: tnaru)
- **管理リポジトリの使い分け**:
    - 各種設定ファイル（WezTerm，Zsh，GlazeWM，Zebar，Lazygit等）は，`~/dotfiles` ではなく，`~/ghq/github.com/Naruto-Takahashi/home-manager-config`（Nix/Home Manager）を正本として宣言的に管理します．
    - 設定変更時は，`home-manager-config` リポジトリ側の Nix ファイルを編集し，変更後は必ず `git add` してから `home-manager switch` を適用すること．
- **設定ファイル実体（旧 dotfiles 管理のもの）**:
    - `~/.zshrc` -> `~/dotfiles/.zshrc`
    - `~/.config/nvim` -> `~/dotfiles/nvim`
    - `~/.local/bin/*` (自作ツール) -> `~/dotfiles/bin/*`
- **Windows連携**: WezTerm，AutoHotkey，GlazeWM 等のWindowsアプリの設定は，WSL側からWindows側の所定のディレクトリへ**コピー**して配置する．
    - パス解決のトラブルを避連するため，Windows側からWSL側へのシンボリックリンクは使用しない．
    - 設定変更後は `.zshrc` に定義された `sync-win` コマンドを実行してWindows側に反映させること．
- **Neovim構成**: `lazy.nvim` によるプラグイン管理，`snacks.nvim` によるUI拡張．詳細は `~/dotfiles/nvim/KEYBINDINGS.md` を参照．
- **機密情報**: APIキー等は `~/.env` で管理し，Gitには絶対にコミットしないこと．

---
## Obsidian External Brain 運用ルール (The Context Garden)
Windows側のObsidian Vault（`/mnt/c/Users/tnaru/Obsidian/Vault`）を「外部脳」として活用し，セッションを跨いで知識を引き継ぎます．

### 1. 読み取り（セッション開始時に必ず実行）
* **最小読み込み**: `01_Meta/PICKUP.md` のみを読み，現在の最優先事項と直近の文脈を把握する．
* **オンデマンド参照**: 指示されたタスクに関連する場合のみ，`PICKUP.md` にあるリンク（Status.md等）を辿って読み込む．
* **検索優先**: 過去の知見が必要な場合，ファイル全体を読み込む前に `grep_search` 等でターゲットを絞り込み，必要な箇所のみを surgical に読む．

### 2. 書き込み（その場でVaultに書き込む。「後で書く」はしない）
* バグ解決，設定ハマり対策，新しい発見などは `04_Library/Knowledge/` に書き込む．
* 判断・設計の方針決定は `04_Library/Decisions/` に書き込む．
* プロジェクトの状態変更は `03_Projects/` に書き込む．
* ユーザーの好みの発見は `05_Profile/` に書き込む．
* **書き込みフォーマット**: ノートには必ず以下のYAMLフロントマターを付与してください．関連ノートには `[[wiki link]]` でリンクする．
  ```markdown
  ---
  date: YYYY-MM-DD
  tags: [relevant, tags]
  project: project-name
  related: [[Other Note]]
  ---
  タイトル
  本文．
  ```
* **mistakes.md への追記**: ユーザーから明示的な訂正を受け，かつ「繰り返し起こり得るパターン」を満たす場合，即座に `04_Library/Knowledge/mistakes.md` に追記してください．
* **報告**: Obsidianを読み書きしたら，必ずユーザーに伝えてください．

### 3. セッション終了時の行動
* **ログの記録**: `02_Journal/YYYY/MM/` 配下に `YYYY-MM-DD_HH-mm-ss.md` の形式でセッションサマリーを作成する．
* **PICKUP の更新（必須）**: 次回の開始コストを下げるため，`01_Meta/PICKUP.md` を最新の状態に更新し，古いポインタを削除する．

---
## リポジトリ管理・開発環境ルール (ghq + Go)
- **Go環境**: `/usr/local/go` (v1.23.4) を利用。GOPATHはデフォルト (`~/go`)．
- **リポジトリ管理**: **ghq** (`~/.local/bin/ghq`) を使用し、すべてのリポジトリを `~/ghq` 配下で一元管理する．
    - **ルートディレクトリ**: `~/ghq` (例: `~/ghq/github.com/user/repo`)
    - **運用フロー**:
        1.  新規プロジェクトは `ghq create project-name` で作成、またはGitHub作成後に `ghq get` で取得する．
        2.  `~/projects` などの別ディレクトリに実体を置かず、すべて `ghq` 管理下に統一する（既存の `~/projects` 内の一部は `~/ghq` へのシンボリックリンクとして残存）．
        3.  移動は `Ctrl+g` (fzf連携) または Neovim内の `<Leader>fq` (Telescope連携) を使用し、パスを意識せずに検索して移動する．

---
## 開発指針 (CLIツール・スクリプト)
- **高速性重視**: Node.jsやPythonランタイムの起動オーバーヘッドを避けるため、可能な限り **Shell Script + curl** で実装する．
- **JSON処理**: 安全かつ高速な処理のために **jq** を使用する．
- **UI/UX**: ユーザー対話には **gum** (Charm) を使用し、リッチで直感的なUIを提供する．
- **AI連携**: Gemini API (Flashモデル) を `curl` で直接叩く構成を推奨する．

---
## クリップボード画像連携 (\cコマンド)
- ユーザーが `/c` コマンドを実行し，出力に "Image captured." が含まれていた場合，あなたは**直ちに** `read_file` ツールを使用して，コマンド内で指定された画像パス（通常は `.gemini/tmp/clipboard_image.png`）を読み込んでください．
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
- WSL distribution name is 'Ubuntu', not 'Ubuntu-24.04'．
- WezTerm config path on Windows is C:\Users\tnaru\.config\wezterm\wezterm.lua．
- WezTerm config files are copied from WSL to Windows, not symlinked．
