return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = true,
    term_colors = true,
    integrations = {
      cmp = true,
      gitsigns = true,
      neo_tree = true,
      treesitter = true,
      telescope = {
        enabled = true,
      },
      snacks = true,
      which_key = true,
      mason = true,
      notify = true,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
    },
    custom_highlights = function(colors)
      return {
        -- Telescopeの枠線を落ち着いたグレーに変更
        TelescopeBorder = { fg = colors.overlay0 },
        TelescopePromptBorder = { fg = colors.overlay0 },
        TelescopeResultsBorder = { fg = colors.overlay0 },
        TelescopePreviewBorder = { fg = colors.overlay0 },
        
        -- タイトル部分も色を合わせる
        TelescopePromptTitle = { fg = colors.base, bg = colors.overlay0 },
        TelescopeResultsTitle = { fg = colors.base, bg = colors.overlay0 },
        TelescopePreviewTitle = { fg = colors.base, bg = colors.overlay0 },
      }
    end,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
