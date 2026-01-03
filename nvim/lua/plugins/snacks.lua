return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
      sections = {
        -- 全体の押し下げ用余白
        { section = "terminal", cmd = "echo $null", height = 5 },
        
        -- 1. ロゴ
        { section = "header", padding = 1, hl = "SnacksDashboardHeader" },
        
        -- 2. 操作メニュー
        { section = "keys", gap = 1, padding = 1 },
        
        -- 3. ギデオンの画像
        {
          section = "terminal",
          cmd = "C:/Users/tnaru/AppData/Local/Microsoft/WinGet/Packages/hpjansson.Chafa_Microsoft.Winget.Source_8wekyb3d8bbwe/chafa-1.18.0-1-x86_64-win/Chafa.exe \"C:/Users/tnaru/Tools/Customization/gideon_cursor/gide_pixel.png\" --size 60x22 --symbols block+vhalf+quad+hhalf --colors full --dither fs --threshold 0.7 --preprocess false",
          height = 25,
          padding = 1,
          indent = 16,
        },
        
        -- 4. 読み込み状況
        { section = "startup", hl = "SnacksDashboardDesc", padding = 1 },
      },
    },
    notifier = { enabled = true },
    terminal = { enabled = true },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    
    local function set_dashboard_colors()
      local brown_light = "#917B62"
      local key_pink    = "#E5A19E"
      local black_logo  = "#756371"
      
      -- ロゴを #756371 に設定
      vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = black_logo, bold = true })
      
      -- 説明文と統計情報を明るい茶色に
      vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = brown_light })
      vim.api.nvim_set_hl(0, "SnacksDashboardStartup", { fg = brown_light })
      vim.api.nvim_set_hl(0, "SnacksDashboardStats", { fg = brown_light })
      vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = brown_light })

      -- キー部分をピンクで固定
      vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = key_pink, bold = true })
    end

    -- 描画タイミングに合わせて色を適用
    vim.api.nvim_create_autocmd({ "VimEnter", "User" }, {
      pattern = { "SnacksDashboardOpened" },
      callback = function()
        vim.defer_fn(set_dashboard_colors, 50)
      end,
    })

    set_dashboard_colors()
  end,
}