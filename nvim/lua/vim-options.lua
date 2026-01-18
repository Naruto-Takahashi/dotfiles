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

-- Clear Highlight
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear Highlight" })

-- Open KEYBINDINGS on GitHub
vim.keymap.set("n", "<leader><leader>m", function()
  local url = "https://github.com/Naruto-Takahashi/dotfiles/blob/main/nvim/KEYBINDINGS.md"
  local cmd
  if vim.fn.has("win32") == 1 then
    cmd = "start " .. url
  elseif vim.fn.has("unix") == 1 then
    if vim.fn.executable("wslview") == 1 then
      cmd = "wslview " .. url
    elseif vim.fn.executable("xdg-open") == 1 then
      cmd = "xdg-open " .. url
    end
  end
  if cmd then
    vim.fn.jobstart(cmd, { detach = true })
  else
    print("Could not find a command to open the browser.")
  end
end, { desc = "Open KEYBINDINGS.md on GitHub" })