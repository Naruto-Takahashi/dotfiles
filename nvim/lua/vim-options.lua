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
