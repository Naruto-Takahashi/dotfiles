return {
  "nvim-treesitter/nvim-treesitter",
  tag = "v0.9.2", -- 安定版に固定（重要！）
  build = ":TSUpdate",
  config = function()
    -- Windows環境用コンパイラ設定
    if vim.fn.has("win32") == 1 then
      require("nvim-treesitter.install").compilers = { "gcc" }
    end

    -- 設定モジュールの呼び出し
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { 
        "c", "cpp", "lua", "vim", "vimdoc", "query", 
        "python", "javascript", "typescript", "markdown", "markdown_inline" 
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true }, 
    })
  end
}
