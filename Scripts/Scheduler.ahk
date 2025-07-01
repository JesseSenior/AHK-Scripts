/*
Copyright (C) 2021-2025 Jesse Senior. All rights reserved.

Author : Jesse Senior <jessesenior@qq.com>
Note   : 定时脚本.
*/
#Requires AutoHotkey v2.0

#HotIf
; 定时检测并关闭窗口的函数
CheckAndCloseWindows() {
    windows := WinGetList("ahk_exe thunderbird.exe")

    Loop windows.Length {
        winTitle := WinGetTitle(windows[A_Index])
        if (winTitle == "Add Security Exception") {  ; 精确匹配标题开头（区分大小写）
            WinClose(windows[A_Index])  ; 关闭找到的窗口
            Sleep 500  ; 短暂等待窗口关闭
        }
    }
}
SetTimer(CheckAndCloseWindows, 60000)

KeepIMETop() {
    if WinExist("ahk_class Microsoft.IME.UIManager.CandidateWindow.Host")
        WinSetAlwaysOnTop(1)
}
SetTimer(KeepIMETop, 200)