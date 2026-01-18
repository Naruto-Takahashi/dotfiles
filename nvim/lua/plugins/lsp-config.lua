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
      local servers = { "lua_ls", "pylsp", "clangd" }

      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
        
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client then
              client.capabilities = vim.tbl_deep_extend("force", client.capabilities, capabilities)
            end
          end,
        })
      end

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