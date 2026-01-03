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
      -- require('lspconfig') を介さず、直接サーバーを有効化します
      
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local servers = { "lua_ls", "pylsp", "clangd" }

      for _, server in ipairs(servers) do
        -- サーバーの設定を更新し、有効化する (0.11 の新方式)
        -- これにより require('lspconfig') の警告が出なくなります
        vim.lsp.enable(server)
        
        -- 必要に応じて個別の設定を行いたい場合は vim.lsp.config を使いますが、
        -- 基本的な capabilities の適用は以下のように行えます
        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client then
              client.capabilities = vim.tbl_deep_extend('force', client.capabilities, capabilities)
            end
          end,
        })
      end

      -- キーマッピング (LSP関連)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
    end,
  },
}