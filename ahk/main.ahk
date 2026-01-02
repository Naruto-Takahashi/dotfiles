#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; --- CapsLock -> Left Control ---
*F13::
    Send, {LCtrl down}
    KeyWait, F13
    Send, {LCtrl up}
Return

; --- Ctrl + Arrows to Scroll ---
^Up::Send {WheelUp}
^Down::Send {WheelDown}
^Left::Send {WheelLeft}
^Right::Send {WheelRight}

; --- Space Key Behavior ---
; Standard behavior: Fire on release
Space Up::Send, {Space}
; Shift + Space: Force normal space (allows repeat)
+Space::Send, {Space}

; --- Vim Navigation (HJKL) ---
Space & h::Send {Blind}{Left}
Space & j::Send {Blind}{Down}
Space & k::Send {Blind}{Up}
Space & l::Send {Blind}{Right}

; --- Home / End ---
Space & a::Send {Blind}{Home}
Space & e::Send {Blind}{End}

; --- Editing ---
Space & u:: Send, ^z          ; Undo
Space & b:: Send, {Backspace} ; Backspace
Space & x:: Send, {Delete}    ; Delete

; --- Virtual Desktop ---
Space & RWin::
    SendInput, {LWin down}{LCtrl down}{LAlt down}{Right}{LAlt up}{LCtrl up}{LWin up}
Return

RWin::
    Send, {LWin down}{LCtrl down}{Right}{LCtrl up}{LWin up}
Return
^Space::Send, ^{Space}

; --- Alt Key IME Switching ---
~LAlt Up::
    if (A_PriorHotkey == "~LAlt")
        SendInput, {vk1Dsc07B}
    Return
~LAlt::SendInput, {vkE8}

~RAlt Up::
    if (A_PriorHotkey == "~RAlt")
        SendInput, {vk1Csc07B}
    Return
~RAlt::SendInput, {vkE8}