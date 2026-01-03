return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- Windows環境用コンパイラ設定
    if vim.fn.has("win32") == 1 then
      require("nvim-treesitter.install").compilers = { "gcc" }
    end

    -- 最新仕様 (v1.0.0+) に基づくセットアップ
    -- require("nvim-treesitter.configs") は廃止されたため、直接 setup を呼びます
    require("nvim-treesitter").setup({
      ensure_installed = { 
        "c", "cpp", "lua", "vim", "vimdoc", "query", 
        "python", "javascript", "typescript", "markdown", "markdown_inline" 
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true }, 
    })
  end
}