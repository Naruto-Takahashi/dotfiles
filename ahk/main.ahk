/*
    =============================================================================
    メイン AutoHotkey スクリプト
    説明: キーリマップ，Vim風ナビゲーション，およびIME統合．
    =============================================================================
*/

; =============================================================================
; グローバル設定
; =============================================================================
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; 外部ライブラリの読み込み
#Include %A_ScriptDir%\lib\ime_functions.ahk

; =============================================================================
; キーリマップ
; =============================================================================

; --- CapsLock -> 左Control ---
; F13（レジストリ/ソフトウェアでCapsLockからマップされたもの）を左Controlにリマップ
*F13::
    Send, {LCtrl down}
    KeyWait, F13
    Send, {LCtrl up}
Return

; =============================================================================
; Spaceキーの拡張 (SandS & Vimモード)
; =============================================================================

; --- SandS (Space and Shift) 動作 ---
; Spaceをタップ: Spaceを出力
Space Up::Send, {Space}
; Shift + Space: Spaceを出力（リピート許可）
+Space::Send, {Space}


; --- Vimナビゲーション (Space + HJKL) ---
Space & h::Send {Blind}{Left}
Space & j::Send {Blind}{Down}
Space & k::Send {Blind}{Up}
Space & l::Send {Blind}{Right}

; --- ナビゲーション拡張 ---
Space & a::Send {Blind}{Home}
Space & e::Send {Blind}{End}

; --- 編集ショートカット ---
Space & u:: Send, ^z          ; 元に戻す
Space & b:: Send, {Backspace} ; Backspace
Space & x:: Send, {Delete}    ; Delete
^Space::    Send, ^{Space}    ; Ctrl + Space (スルー)


; =============================================================================
; 仮想デスクトップ操作
; =============================================================================

; --- デスクトップ切り替え (右) ---
; RWin または RCtrl -> 次のデスクトップへ切り替え
RWin:: Send, {LWin down}{LCtrl down}{Right}{LCtrl up}{LWin up}
RCtrl::Send, {LWin down}{LCtrl down}{Right}{LCtrl up}{LWin up}

; --- ウィンドウを次のデスクトップへ移動 ---
; Alt + RWin/RCtrl -> アクティブウィンドウを次のデスクトップへ移動
!RWin:: SendInput, {LWin down}{LCtrl down}{LAlt down}{Right}{LAlt up}{LCtrl up}{LWin up}
!RCtrl::SendInput, {LWin down}{LCtrl down}{LAlt down}{Right}{LAlt up}{LCtrl up}{LWin up}


; =============================================================================
; IME & Vim統合
; =============================================================================

; --- AltキーによるIME切り替え (Mac風) ---
; 左Alt: IME OFF (英数)
~LAlt Up::
    if (A_PriorHotkey == "~LAlt")
        IME_SET(0)
    Return
~LAlt::SendInput, {vkE8} ; 無効化

; 右Alt: IME ON (日本語)
~RAlt Up::
    if (A_PriorHotkey == "~RAlt")
        IME_SET(1)
    Return
~RAlt::SendInput, {vkE8} ; 無効化

; --- Vim Escape & IME OFF ---
; Escapeを押すとEscを送信し，強制的にIMEをOFFにする
$Esc::
    Send, {Esc}
    Sleep 10 ; IME切り替えの前にEscが処理されるようにわずかな遅延を入れる
    IME_SET(0)
Return