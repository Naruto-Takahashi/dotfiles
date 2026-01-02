#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; F13(CapsLockキー) → 左Control
*F13::
    Send, {LCtrl down}
    KeyWait, F13
    Send, {LCtrl up}
Return

; Ctrl + ↑ でスクロールアップ
^Up::Send {WheelUp}

; Ctrl + ↓ でスクロールダウン
^Down::Send {WheelDown}

; Ctrl + ← で左スクロール
^Left::Send {WheelLeft}

; Ctrl + → で右スクロール
^Right::Send {WheelRight}

; Space単体 → 普通に空白を入力
Space::
    Send, {Space}
Return

; Space + ?? → 各種操作
Space & u:: Send, ^z
Space & b:: Send, {Backspace}
Space & o:: Send, {Delete}
Space & h:: Send, {Home}
Space & `;:: Send, {End}
Space & n:: Send, {Insert}
Space & f:: Send, {vk1Dsc07B}  ; 無変換キー
Space & j:: Send, {vk1Csc07B}  ; 変換キー

; スペース+右Win → アクティブなタブをデスクトップ間で移動
Space & RWin::
    SendInput, {LWin down}{LCtrl down}{LAlt down}{Right}{LAlt up}{LCtrl up}{LWin up}
Return

; 右Win → デスクトップ切り替え
RWin::
    Send, {LWin down}{LCtrl down}{Right}{LCtrl up}{LWin up}
Return
^Space::Send, ^{Space}
