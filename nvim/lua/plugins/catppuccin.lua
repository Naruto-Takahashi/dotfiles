return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    transparent_background = true, -- 透過を有効化
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = true,
    },
    custom_highlights = function(colors)
      local logo_color = "#756371"
      local brown_light = "#917B62"
      local pink_light = "#E5A19E"
      return {
        -- Telescope
        TelescopeBorder = { fg = logo_color },
        TelescopePromptBorder = { fg = logo_color },
        TelescopeResultsBorder = { fg = logo_color },
        TelescopePreviewBorder = { fg = logo_color },
        TelescopeTitle = { fg = logo_color },
        TelescopePromptTitle = { fg = logo_color },
        
        -- Editor
        LineNr = { fg = brown_light },
        CursorLineNr = { fg = brown_light, bold = true },
        CursorLine = { bg = colors.surface0, underline = false },
      }
    end,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}