/*
Copyright (C) 2021-2025 Jesse Senior. All rights reserved.

Author : Jesse Senior <jessesenior@qq.com>
Note   : 键盘/鼠标映射.
*/
#Requires AutoHotkey v2.0
#Include IncludeCommon.ahk

; 防止快捷键在宿主机被拦截
#HotIf WinActive("ahk_group RemoteAccess")
CapsLock:: return
~XButton1:: return
~XButton2:: return
~RControl:: return

#HotIf not WinActive("ahk_group RemoteAccess")
; 使用CapsLock来切换中英文（长按）
CapsLock::
{
    if WinActive("ahk_exe osu!.exe") ; 忽略部分应用
        return

    capsState := GetKeyState("CapsLock", "T")
    IMEState := getIMEState()
    BlockInput 'On'

    ; 检测输入法是否有内容，并自动上屏
    try {
        ; 讯飞输入法 或 小狼毫
        if (WinExist("ahk_exe iFlyInput.exe") or WinExist("ahk_class BaseGui"))
            Send("{Enter}")
        ; 微软输入法
        else if WinExist("ahk_class Microsoft.IME.UIManager.CandidateWindow.Host")
            Send("{Enter}")
        else if ControlGetVisible("Windows 输入体验", "ahk_exe explorer.exe")
            Send("{Enter}")
    }

    KeyWait("CapsLock")
    if A_TimeSinceThisHotkey > 500 and IMEState = 0 ; 长按+英文模式才切换大小写
        SetCapsLockState capsState = 0 ? "On" : "Off"
    else { ; 否则自动切换中英文并强制关闭大小写
        SetCapsLockState "Off"

        Send("{Alt down}{Shift down}")
        Sleep(30)
        Send("{Alt up}{Shift up}")
    }
    Sleep(30)
    BlockInput 'Off'
}

; 回到桌面/虚拟桌面
XButton1:: Send "#d"
XButton2:: Send "#{Tab}"

; 鼠标滚轮加速
XButton2 & WheelDown:: Send "{WheelDown 5}"
XButton2 & WheelUp:: Send "{WheelUp 5}"

; 鼠标水平滚轮
XButton1 & WheelDown:: Send "{WheelRight}"
XButton1 & WheelUp:: Send "{WheelLeft}"

; 虚拟桌面切换
<#XButton1::
VDSR_(hk := 0) {
    WinActivate "ahk_class Shell_TrayWnd"
    WinWaitActive "ahk_class Shell_TrayWnd"
    Send "#^{Right}"
    ;WinMinimize "ahk_class Shell_TrayWnd"
}
<#XButton2::
VDSL_(hk := 0) {
    WinActivate "ahk_class Shell_TrayWnd"
    WinWaitActive "ahk_class Shell_TrayWnd"
    Send "#^{Left}"
    ;WinMinimize "ahk_class Shell_TrayWnd"
}

; 历史记录切换
<!XButton1:: Send "!{Right}"
<!XButton2:: Send "!{Left}"

; 音乐播放
;<^<!p:: Send "{Media_Play_Pause}"
;<^<!m:: {
;    if (WinExist("ahk_exe YouTube Music.exe"))
;    {
;        WinClose
;        Return
;    }
;    else
;    {
;        Run "YouTube Music.exe", "C:\Users\" . A_UserName . "\scoop\apps\youtube-music\current"
;        Return
;    }
;}
;<^<!Left:: Send "{Media_Prev}"
;<^<!Right:: Send "{Media_Next}"
;<^<!Up:: Send "{Volume_Up}"
;<^<!Down:: Send "{Volume_Down}"

; PixPin
#HotIf not WinActive("ahk_exe java.exe")
<^1:: Send "^!+1"
<^2:: Send "^!+2"
<^3:: Send "^!+3"
#HotIf

; 标签页切换
#HotIf WinActive("ahk_exe chrome.exe")
<+XButton2:: Send "^+a"
#HotIf

<^XButton1:: Send "^{Tab}"
<^XButton2:: Send "^+{Tab}"

; 功能键映射
XButton2 & 1:: Send "{F1}"
XButton2 & 2:: Send "{F2}"
XButton2 & 3:: Send "{F3}"
XButton2 & 4:: Send "{F4}"
XButton2 & 5:: Send "{F5}"
XButton2 & 6:: Send "{F6}"
XButton2 & 7:: Send "{F7}"
XButton2 & 8:: Send "{F8}"
XButton2 & 9:: Send "{F9}"
XButton2 & 0:: Send "{F10}"
XButton2 & -:: Send "{F11}"
XButton2 & =:: Send "{F12}"

; 快速光标移动
*>^Left:: MoveCursor("{Home}")
*>^Right:: MoveCursor("{End}")
*>^Up:: MoveCursor("{PgUp}")
*>^Down:: MoveCursor("{PgDn}")

; 窗口置顶
XButton2 & t::
RControl & t:: WinSetAlwaysOnTop -1, "A"

; 居中窗口
XButton2 & r::
RControl & r:: CenterWindow("A", Settings.NormalWidthRatio, Settings.NormalHeightRatio)

; Minecraft 自动放屁
global mc_shift_flat := false

#HotIf not WinActive("ahk_group RemoteAccess") and WinActive("Minecraft 1.12.2")
XButton2 & f:: {
    global mc_shift_flat
    mc_shift_flat := !mc_shift_flat  ; 反转状态变量
    if (mc_shift_flat) {
        SetTimer(mc_shift, 140)  ; 如果标志为 true，则以 50ms 间隔启动 Timer
    } else {
        SetTimer(mc_shift, 0) ; 如果标志为 false，则关闭 Timer
    }
}
XButton2 & g:: Send("{LButton Down}")
#HotIf

mc_shift() {
    global mc_shift_flat
    if (!mc_shift_flat)
        return
    Send("{Shift down}")  ; 按下 Shift 键
    Sleep(70)           ; 等待 50 毫秒
    Send ("{Shift up}")    ; 松开 Shift 键
}