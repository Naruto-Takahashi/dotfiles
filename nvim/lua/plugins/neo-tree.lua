return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- <leader>e でファイルツリーの開閉（トグル）
    vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', {})
    
    -- 必要なら、起動時にNetrwを無効化する設定などをここに書くこともあります
  end
}
