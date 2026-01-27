-- ==========================================================================
--  General Settings (vim-options.lua)
-- ==========================================================================

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")
vim.cmd("set relativenumber") -- 動画では relative number を使うことが多いので合わせますが、お好みで変えてください
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set mouse=a")
vim.g.mapleader = " " -- スペースキーをリーダーキーにする（Typecraft推奨）

-- Transparency settings (背景透過設定)
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local hl = vim.api.nvim_set_hl
    local no_bg = { bg = "none" }
    hl(0, "Normal", no_bg)
    hl(0, "NormalFloat", no_bg)
    hl(0, "NormalNC", no_bg)
    hl(0, "SignColumn", no_bg)
    hl(0, "LineNr", { bg = "none", fg = "#7aa2f7" })
    hl(0, "CursorLineNr", { bg = "none", bold = true })
    hl(0, "CursorLine", { bg = "none", underline = true })
  end,
})

-- Keymaps
vim.keymap.set("n", "<leader>cd", ":Ex<CR>", { desc = "Open Netrw Explorer" })

-- OS Specific Settings
if vim.fn.has("win32") == 1 then
  -- [Windows]
  vim.opt.makeprg = "mingw32-make"
  -- Shell configuration (PowerShell)
  vim.opt.shell = "powershell.exe"
  vim.opt.shellcmdflag = "-NoProfile -NoLogo -NonInteractive -Command"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
else
  -- [Linux / WSL]
  vim.opt.makeprg = "make"
  -- Shell is usually bash/zsh by default, so no need to change
end

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate Left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate Up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate Right" })

-- Better Indent
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left and Stay" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right and Stay" })

-- Exit Insert Mode with jk
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })

-- Clear Highlight
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear Highlight" })

-- Open KEYBINDINGS on GitHub
vim.keymap.set("n", "<leader>m", function()
  local url = "https://github.com/Naruto-Takahashi/dotfiles/blob/main/nvim/KEYBINDINGS.md"
  local cmd
  if vim.fn.has("win32") == 1 then
    cmd = "start " .. url
  else
    -- WSL / Linux: Use powershell.exe to open the browser on Windows
    cmd = string.format("powershell.exe -Command Start-Process '%s'", url)
  end
  vim.fn.jobstart(cmd, { detach = true })
end, { desc = "Open KEYBINDINGS.md on GitHub" })

-- ==========================================================================
--  Zenn Tools (Custom)
-- ==========================================================================
-- 既存の get-clip-img スクリプトを利用して、Windowsクリップボードの画像を
-- 現在のZenn記事プロジェクトの images ディレクトリに保存し、Markdownリンクを挿入します。

local function paste_zenn_image()
  -- プロジェクトルート検出（.gitがある場所、なければカレント）
  local root = vim.fs.dirname(vim.fs.find(".git", { path = vim.fn.expand("%:p:h"), upward = true })[1]) or vim.fn.getcwd()

  -- 現在のファイル名（拡張子なし）をslugとして取得
  local slug = vim.fn.expand("%:t:r")
  
  -- デフォルトファイル名の生成
  local date = os.date("%Y%m%d%H%M%S")
  local default_name
  
  -- slugが取得できればフォルダ分けする
  if slug and slug ~= "" then
    default_name = slug .. "/image-" .. date
  else
    default_name = "image-" .. date
  end

  -- ファイル名（パス）の入力
  vim.ui.input({ prompt = "Image name (under /images/): ", default = default_name }, function(input)
    if not input or input == "" then
      return -- キャンセルまたは空入力
    end

    -- 拡張子 .png がなければ付与（get-clip-imgがpngを出力するため）
    if not input:match("%.png$") then
      input = input .. ".png"
    end

    -- Zenn推奨の images ディレクトリ配下に保存
    local img_rel_path = "/images/" .. input
    local fullpath = root .. img_rel_path
    local img_dir = vim.fs.dirname(fullpath)

    -- ディレクトリが存在しない場合は作成
    if vim.fn.isdirectory(img_dir) == 0 then
      vim.fn.mkdir(img_dir, "p")
    end

    -- スクリプト実行
    local cmd = "get-clip-img " .. vim.fn.shellescape(fullpath)

    vim.notify("Saving image to " .. img_rel_path .. " ...", vim.log.levels.INFO)
    local result = vim.fn.system(cmd)

    if vim.v.shell_error == 0 then
      -- 成功時: 相対パスでMarkdownリンクを挿入
      local insert_text = "![](" .. img_rel_path .. ")"
      vim.api.nvim_put({insert_text}, "c", true, true)
      vim.notify("Saved: " .. img_rel_path, vim.log.levels.INFO)
    else
      -- 失敗時
      vim.notify("Failed: " .. result, vim.log.levels.ERROR)
    end
  end)
end

-- キーバインド設定: <leader>ip
vim.keymap.set("n", "<leader>ip", paste_zenn_image, { desc = "Paste Image (Zenn/Custom)" })