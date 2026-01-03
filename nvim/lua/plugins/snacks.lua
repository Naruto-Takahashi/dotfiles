return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
      sections = {
        -- 左側 (Pane 1): 余白 + ロゴとメニュー
        {
          pane = 1,
          { section = "terminal", cmd = "echo $null", height = 8 },
          {
            section = "header",
            padding = 1,
            hl = "SnacksDashboardHeader",
          },
          { section = "keys", gap = 1, padding = 1 },
          {
            section = "startup",
            hl = "SnacksDashboardHeader",
          },
        },
        -- 右側 (Pane 2): 余白 + ギデオンの画像
        {
          pane = 2,
          { section = "terminal", cmd = "echo $null", height = 8 },
          {
            section = "terminal",
            cmd = "C:/Users/tnaru/AppData/Local/Microsoft/WinGet/Packages/hpjansson.Chafa_Microsoft.Winget.Source_8wekyb3d8bbwe/chafa-1.18.0-1-x86_64-win/Chafa.exe \"C:/Users/tnaru/Tools/Customization/gideon_cursor/gide_pixel.png\" --size 60x25 --symbols block+vhalf+quad+hhalf --colors full --dither fs",
            height = 35,
            padding = 1,
            indent = 2,
          },
        },
      },
    },
    notifier = { enabled = true },
    terminal = { enabled = true },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    
    local function set_dashboard_colors()
      local brown_main = "#917B62" -- 明るい茶色
      local brown_dark = "#4A3B43" -- 深い色
      
      -- ロゴと統計情報を「深い色 (#4A3B43)」に変更
      local dark_groups = {
        "SnacksDashboardHeader",
        "SnacksDashboardStartup",
        "SnacksDashboardStats",
        "SnacksDashboardFooter",
      }
      for _, group in ipairs(dark_groups) do
        vim.api.nvim_set_hl(0, group, { fg = brown_dark, bold = (group == "SnacksDashboardHeader") })
      end

      -- 説明文を「明るい茶色 (#917B62)」に変更
      vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = brown_main })
    end

    vim.api.nvim_create_autocmd({ "VimEnter", "User" }, {
      pattern = { "SnacksDashboardOpened" },
      callback = function()
        vim.defer_fn(set_dashboard_colors, 50)
      end,
    })

    set_dashboard_colors()
  end,
}
