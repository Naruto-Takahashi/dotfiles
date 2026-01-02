local wezterm = require("wezterm")
local act = wezterm.action

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
  local name = window:active_key_table()
  if name then
    name = "TABLE: " .. name
  end
  window:set_right_status(name or "")
end)

return {
  keys = {
    -- ============================================================
    -- Leader Key (Ctrl+Space) -> Tab操作
    -- ============================================================

    -- Leader + t で新しいタブを作成 (Tab)
    { key = "t", mods = "LEADER", action = act({ SpawnTab = "CurrentPaneDomain" }) },

    -- Leader + w でタブを閉じる (Close Window)
    -- ※確認画面が出ます
    { key = "w", mods = "LEADER", action = act({ CloseCurrentTab = { confirm = true } }) },

    -- ============================================================
    -- ワークスペース関連 (w をタブ用に譲ったので、大文字 W に変更)
    -- ============================================================

    -- Leader + Shift + w (大文字W) でワークスペース選択
    { key = "W", mods = "LEADER|SHIFT", action = act.ShowLauncherArgs({ flags = "WORKSPACES", title = "Select workspace" }), },

    -- ワークスペース名変更などはそのまま
    {
      key = "$", mods = "LEADER",
      action = act.PromptInputLine({
        description = "(wezterm) Set workspace title:",
        action = wezterm.action_callback(function(win, pane, line)
          if line then wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line) end
        end),
      }),
    },

    -- ============================================================
    -- その他の便利なショートカット
    -- ============================================================

    -- タブの移動 (Leader + n / p) next/previous
    { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
    { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },

    -- タブの入れ替え
    { key = "{", mods = "LEADER|SHIFT", action = act({ MoveTabRelative = -1 }) },
    { key = "}", mods = "LEADER|SHIFT", action = act({ MoveTabRelative = 1 }) },

    -- 数字キーでの移動 (Alt + 数字)
    { key = "1", mods = "ALT", action = act.ActivateTab(0) },
    { key = "2", mods = "ALT", action = act.ActivateTab(1) },
    { key = "3", mods = "ALT", action = act.ActivateTab(2) },
    { key = "4", mods = "ALT", action = act.ActivateTab(3) },
    { key = "5", mods = "ALT", action = act.ActivateTab(4) },
    { key = "6", mods = "ALT", action = act.ActivateTab(5) },
    { key = "7", mods = "ALT", action = act.ActivateTab(6) },
    { key = "8", mods = "ALT", action = act.ActivateTab(7) },
    { key = "9", mods = "ALT", action = act.ActivateTab(-1) },

    -- ペイン操作 (分割・移動)
    { key = "d", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "r", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "x", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },
    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

    -- コピーモード (Leader + [ )
    { key = "[", mods = "LEADER", action = act.ActivateCopyMode },

    -- コマンドパレット (Ctrl + Shift + P)
    { key = "p", mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },

    -- コピー & 貼り付け (Ctrl + Shift + C/V)
    { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
    { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

    -- フォントサイズ
    { key = "+", mods = "CTRL", action = act.IncreaseFontSize },
    { key = "-", mods = "CTRL", action = act.DecreaseFontSize },
    { key = "0", mods = "CTRL", action = act.ResetFontSize },

    -- 設定リロード
    { key = "r", mods = "CTRL|SHIFT", action = act.ReloadConfiguration },

    -- キーテーブル
    { key = "s", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
    { key = "a", mods = "LEADER", action = act.ActivateKeyTable({ name = "activate_pane", timeout_milliseconds = 1000 }) },
  },

  -- キーテーブル設定（変更なし）
  key_tables = {
    resize_pane = {
      { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
      { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
      { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
      { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
      { key = "Enter", action = "PopKeyTable" },
      { key = "Escape", action = "PopKeyTable" },
    },
    activate_pane = {
      { key = "h", action = act.ActivatePaneDirection("Left") },
      { key = "l", action = act.ActivatePaneDirection("Right") },
      { key = "k", action = act.ActivatePaneDirection("Up") },
      { key = "j", action = act.ActivatePaneDirection("Down") },
    },
    copy_mode = {
      { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
      { key = "c", mods = "CTRL", action = act.CopyMode("Close") },
      { key = "q", mods = "NONE", action = act.CopyMode("Close") },
      { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
      { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
      { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
      { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
      { key = "y", mods = "NONE", action = act.CopyTo("Clipboard") },
      { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
      { key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
      { key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
      { key = "Enter", mods = "NONE", action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }) },
      -- その他の移動キーなどが必要であれば公式設定からコピーしてください
    },
  },
}
