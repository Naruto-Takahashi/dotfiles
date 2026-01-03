return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      -- エラー回避のため一旦 setup を保留
      -- require("mason-lspconfig").setup({
      --   ensure_installed = { "lua_ls", "pylsp", "clangd" },
      -- })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- LSP自体のセットアップも一旦保留
    end,
  },
}