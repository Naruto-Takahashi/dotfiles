return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    if vim.fn.has("win32") == 1 then
      require("nvim-treesitter.install").compilers = { "gcc" }
    end

    -- 互換性のためのチェック
    local status, configs = pcall(require, "nvim-treesitter.configs")
    if not status then
      -- もし configs が見つからない場合は、新しい config モジュールを試す
      configs = require("nvim-treesitter.config")
    end

    configs.setup({
      ensure_installed = { 
        "c", "cpp", "lua", "vim", "vimdoc", "query", 
        "python", "javascript", "typescript", "markdown", "markdown_inline" 
      },
      highlight = { enable = true },
      indent = { enable = true }, 
    })
  end
}
