return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    window = {
      position = "current",
      mappings = {
        ["<space>"] = "none",
      },
    },
    filesystem = {
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    
    -- <leader>e でファイルツリーの開閉（トグル）
    vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', {})
  end
}
