return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- ここに使いたい言語のLSPサーバー名を書くと自動でインストールされます
        ensure_installed = { 
          "lua_ls",       -- Lua
          "pylsp",        -- Python
          "clangd",       -- C/C++
        }
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- [Suppress Warning] Temporarily disable vim.notify to hide lspconfig deprecation warning
      local notify_orig = vim.notify
      vim.notify = function() end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      
      -- 各言語サーバーのセットアップ
      -- ここで setup({}) を呼ばないとNeoVimと連携しません
      
      -- 1. Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      
      -- 2. Python
      lspconfig.pylsp.setup({
        capabilities = capabilities
      })

      -- 3. C/C++
      lspconfig.clangd.setup({
        capabilities = capabilities
      })

      -- [Restore Warning] Restore vim.notify
      vim.notify = notify_orig

      -- キーマッピング (LSP関連)
      -- K: ホバー表示 (ドキュメント表示)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      -- gd: 定義元へジャンプ
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      -- <space>ca: コードアクション (修正提案)
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
    end,
  },
}
