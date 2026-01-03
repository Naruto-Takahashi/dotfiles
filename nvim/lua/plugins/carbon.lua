return {
  "ellisonleao/carbon-now.nvim",
  lazy = true,
  cmd = "CarbonNow",
  opts = {
    open_cmd = "cmd.exe /c start", -- Windows用のブラウザ起動コマンド
    options = {
      theme = "monokai",
      font_family = "Fira Code",
      font_size = "14px",
      line_numbers = true,
      window_theme = "none",
    },
  },
}
