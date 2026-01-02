local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.font = wezterm.font 'HackGen Console NF'
config.font_size = 12.0
config.initial_cols = 120
config.initial_rows = 35
config.use_ime = true
config.warn_about_missing_glyphs = false
config.window_background_opacity = 0.75
config.macos_window_background_blur = 20

----------------------------------------------------
-- Tab
----------------------------------------------------
-- タイトルバーを非表示
config.window_decorations = "RESIZE"
-- タブバーの表示
config.show_tabs_in_tab_bar = true
-- タブが一つの時は非表示
config.hide_tab_bar_if_only_one_tab = false
-- falseにするとタブバーの透過が効かなくなる
-- config.use_fancy_tab_bar = false

-- タブバーの透過
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}

-- タブバーを背景色に合わせる
config.window_background_gradient = {
  colors = { "#000000" },
}

-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = true
-- nightlyのみ使用可能
-- タブの閉じるボタンを非表示
config.show_close_tab_button_in_tabs = true

-- タブ同士の境界線を非表示
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
}

-- タブの形をカスタマイズ
-- タブの左側の装飾
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
-- タブの右側の装飾
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#FFFFFF"
  local edge_background = "none"

  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#FFFFFF"
  end

  local edge_foreground = background
  
  -- 1. まずデフォルトのタイトルを取得
  local title_text = tab.active_pane.title
  
  -- 2. 裏で動いているプログラムのファイル名を取得（例: "C:\Windows\System32\cmd.exe"）
  local process = tab.active_pane.foreground_process_name or ""

  -- 3. プロセス名に含まれる文字でタイトルを強制上書き
  if process:find("cmd.exe") then
    title_text = "CMD"
  elseif process:find("powershell.exe") or process:find("pwsh.exe") then
    title_text = "PowerShell"
  elseif process:find("wsl.exe") or process:find("wslhost.exe") then
    title_text = "Ubuntu"  -- WSLなら「Ubuntu」にする
  elseif process:find("nvim") then
    title_text = "Neovim"  -- ついでにNeovimを開いている時もわかりやすく
  end

  local title = "   " .. wezterm.truncate_right(title_text, max_width - 1) .. "   "

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

-- =============================================================================
-- Shell Configuration (Updated for WSL Ubuntu)
-- =============================================================================

-- 起動時に PowerShell を立ち上げる設定
config.default_prog = { 'powershell.exe', '-nologo' }

-- 「＋」ボタンを右クリックしたときのメニュー
config.launch_menu = {
  {
    -- PowerShell のフルパス
    label = 'PowerShell (Windows)',
    args = { 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe', '-nologo' },
  },
  {
    -- Command Prompt (最強版)
    label = 'Command Prompt',
    args = { 'C:\\Windows\\System32\\cmd.exe', '/k' },
  },
  {
	-- WSL Ubuntu の起動
	label = 'WSL (Ubuntu)',
	args = { 'wsl.exe', '--cd', '~' },
  },
}

----------------------------------------------------
-- keybinds
----------------------------------------------------
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 2000 }

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config
