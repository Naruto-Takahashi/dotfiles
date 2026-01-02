#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; --- CapsLock -> Ctrl ---
*F13::
    SendInput, {LCtrl down}
    KeyWait, F13
    SendInput, {LCtrl up}
Return

; --- Ctrl + 矢印でスクロール ---
^Up::SendInput {WheelUp}
^Down::SendInput {WheelDown}
^Left::SendInput {WheelLeft}
^Right::SendInput {WheelRight}

; --- Alt空打ちでIME切り替え (alt-ime-ahk風) ---
; 左Alt空打ち -> 無変換(IME OFF)
LAlt up::
    if (A_PriorHotkey == "*~LAlt")
    {
        SendInput, {vk1Dsc07B}
    }
    Return
*~LAlt::Return

; 右Alt空打ち -> 変換(IME ON)
RAlt up::
    if (A_PriorHotkey == "*~RAlt")
    {
        SendInput, {vk1Csc07B}
    }
    Return
*~RAlt::Return

; --- Spaceキーの基本動作 ---
; Spaceキーを修飾キーとして使うため、単体押しは「離したとき」に反応
Space::SendInput {Space}

; --- Vimカーソル移動 (HJKL) ---
Space & h::SendInput {Blind}{Left}
Space & j::SendInput {Blind}{Down}
Space & k::SendInput {Blind}{Up}
Space & l::SendInput {Blind}{Right}

; --- 行頭・行末 (Home/End) ---
Space & a::SendInput {Blind}{Home}
Space & e::SendInput {Blind}{End}

; --- 削除操作 (Delete/Backspace) ---
Space & x::SendInput {Blind}{Delete}    ; Vimのx (カーソル位置削除)
Space & b::SendInput {Blind}{Backspace} ; Back (一文字戻って削除)

; --- 仮想デスクトップ操作 ---
; Space + 右Win で移動
Space & RWin::SendInput {LWin down}{LCtrl down}{LAlt down}{Right}{LAlt up}{LCtrl up}{LWin up}
; 右Win単体で移動
RWin::SendInput {LWin down}{LCtrl down}{Right}{LCtrl up}{LWin up}
^Space::SendInput ^{Space}