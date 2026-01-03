return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    transparent_background = false, -- 透過をオフにして色を固定
    color_overrides = {
      mocha = {
        base = "#000000", -- 背景を完全な黒に変更
        mantle = "#010101",
        crust = "#020202",
      },
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}