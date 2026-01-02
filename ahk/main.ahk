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

; --- Space Key Behavior (Long press to repeat) ---
$Space::
    KeyWait, Space, T0.25 ; Wait 0.25s to verify long press
    if (ErrorLevel) { ; Long pressed
        Send {Space}
        Loop {
            if !GetKeyState("Space", "P")
                break
            Send {Space}
            Sleep 30
        }
    } else { ; Short pressed
        Send {Space}
    }
return

; --- Space Combinations ---
Space & u:: Send, ^z          ; Undo
Space & b:: Send, {Backspace} ; Backspace
Space & o:: Send, {Delete}
Space & h:: Send, {Home}
Space & `;:: Send, {End}
Space & n:: Send, {Insert}
Space & f:: Send, {vk1Dsc07B} ; Muhenkan
Space & j:: Send, {vk1Csc07B} ; Henkan

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