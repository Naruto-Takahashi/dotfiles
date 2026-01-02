return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
--      or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        local builtin = require("telescope.builtin")
        
        -- キーマッピングの設定
        -- <space>ff : ファイル名を検索
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        
        -- <space>fg : ファイル内の文字を検索 (要: ripgrep)
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        
        -- <space>fb : 開いているバッファを検索
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        
        -- <space>fh : ヘルプタグを検索
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      end
    }
}
