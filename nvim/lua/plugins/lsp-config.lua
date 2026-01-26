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
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pylsp", "clangd" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Neovim 0.11+ の新しい作法
      
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      
      -- lua_ls
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      -- pylsp
      lspconfig.pylsp.setup({
        capabilities = capabilities,
      })

      -- clangd (C++)
      -- --query-driver を追加して、システム上の g++ のパスを自動認識させる
      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--query-driver=/usr/bin/g++,/usr/bin/c++",
        },
      })

      -- キーマッピング (LSP関連)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

      -- 診断 (Diagnostics) 関連
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {})
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {})
    end,
  },
}