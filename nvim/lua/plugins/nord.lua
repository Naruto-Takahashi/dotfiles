return {
  "shaunsingh/nord.nvim",
  priority = 1000, -- 最初に読み込む
  config = function()
    vim.g.nord_disable_background = true
    vim.cmd.colorscheme("nord")
  end
}
