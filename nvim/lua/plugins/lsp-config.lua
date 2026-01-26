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
      -- Neovim 0.11+ の新しい作法 (Reverted to original working state)
      
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local servers = { "lua_ls", "pylsp" } -- clangd は個別に設定するためここから外す

      for _, server in ipairs(servers) do
        -- vim.lsp.enable(server) -- Neovim 0.11+ (今回は lspconfig の setup を使う形に統一しても良いが、既存踏襲)
        -- lspconfig を使う場合は通常 setup() を呼ぶのが定石
        lspconfig[server].setup({
            capabilities = capabilities
        })
      end
      
      -- clangd (C++) 個別設定
      local clangd_cmd = { "clangd", "--background-index" }
      local cxx_path = vim.fn.exepath("g++")
      if cxx_path == "" then
        cxx_path = vim.fn.exepath("clang++")
      end

      if cxx_path ~= "" then
        -- コンパイラが見つかれば、そのパスだけでなく全てのバージョンを許可するパターンを追加
        table.insert(clangd_cmd, "--query-driver=" .. cxx_path .. ",/usr/bin/g++*,/usr/bin/clang++*")
      end

      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = clangd_cmd,
      })

      -- LspAttach の設定 (共通)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client then
            client.capabilities = vim.tbl_deep_extend("force", client.capabilities, capabilities)
          end
        end,
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