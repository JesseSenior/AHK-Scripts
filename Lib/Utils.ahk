/*
Copyright (C) 2021-2025 Jesse Senior. All rights reserved.

Author : Jesse Senior <jessesenior@qq.com>
Note   : 常用库.
*/
#Requires AutoHotkey v2.0

MoveCursor(key) {
    if GetKeyState("SHIFT", "P")
        key := "+" key
    if GetKeyState("ALT", "P")
        key := "!" key
    if GetKeyState("LCONTROL", "P")
        key := "^" key
    Send key
}

CenterWindow(WinTitle, NormalWidthRatio, NormalHeightRatio)
{
    ; 获取窗口对应的进程名称
    if (WinTitle = "A") {
        try processName := WinGetProcessName(WinTitle)
        catch  ; 当窗口不存在时直接返回
            return
    }
    else
        processName := WinTitle

    ; 恢复窗口避免最大化状态影响
    try WinRestore(WinTitle)

    ; 忽略特定窗口尺寸调整
    noRescaleProcessName := [
        "explorer.exe",
        "WindowsTerminal.exe",
        "KeePass.exe",
        "Obsidian.exe",
        "cloudmusic.exe",
        "MAA.exe"
    ]

    ; 根据进程类型设置不同尺寸
    if HasVal(noRescaleProcessName, processName)
        WinGetPos(, , &Width, &Height, WinTitle)
    else {
        ; Width := A_ScreenWidth // 3 * 2  ; 默认宽度：屏幕2/3
        ; Height := A_ScreenHeight // 4 * 3 ; 默认高度：屏幕3/4
        Width := Min(Max(A_ScreenWidth * NormalWidthRatio, 960), A_ScreenWidth)
        Height := Min(Width * NormalHeightRatio, A_ScreenHeight)
    }
    Width := Integer(Width)
    Height := Integer(Height)

    ; 计算居中坐标
    xPos := (A_ScreenWidth - Width) // 2
    yPos := (A_ScreenHeight - Height) // 2

    ; 应用新位置和尺寸
    WinMove(xPos, yPos, Width, Height, WinTitle)
}

HasVal(haystack, needle) {
    for index, value in haystack
        if (value == needle)
            return index
    return 0
}

RefreshEnvironment()
{
    Path := ""
    PathExt := ""
    RegKeys := "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment,HKCU\Environment"
    Loop Parse, RegKeys, "CSV"
    {
        Loop Reg, A_LoopField, "V"
        {
            Value := RegRead()
            If (A_LoopRegType == "REG_EXPAND_SZ" && !ExpandEnvironmentStrings(&Value))
                Continue
            If (A_LoopRegName = "PATH")
                Path .= Value . ";"
            Else If (A_LoopRegName = "PATHEXT")
                PathExt .= Value . ";"
            Else
                EnvSet A_LoopRegName, Value
        }
    }
    EnvSet PATH, Path
    EnvSet PATHEXT, PathExt
}

ExpandEnvironmentStrings(&vInputString)
{
    ; get the required size for the expanded string
    vSizeNeeded := DllCall("ExpandEnvironmentStrings", "Str", vInputString, "Int", 0, "Int", 0)
    If (vSizeNeeded == "" || vSizeNeeded <= 0)
        return False    ; unable to get the size for the expanded string for some reason

    vByteSize := vSizeNeeded + 1
    VarSetStrCapacity(&vTempValue, vByteSize)

    ; attempt to expand the environment string
    If (!DllCall("ExpandEnvironmentStrings", "Str", vInputString, "Str", vTempValue, "Int", vSizeNeeded))
        return False    ; unable to expand the environment string
    vInputString := vTempValue

    ; return success
    Return True
}

; Modified from Ref: https://www.cnblogs.com/hyaray/p/12657774.html
toIME(i := 0) {
    if (type(i) == "Integer") {
        if (i = -1)
            i := 1 - getIMEState()
        switch i {
            case 0: sID := "00000409" ;美式键盘-ENG
            case 1: sID := "00000804" ;中文 也可用 E0200804
            default: return
        }
    } else {
        sID := i
    }
    WinActive("A")
    ctl := ControlGetFocus() || WinGetID()
    PostMessage(0x50, , dllcall("LoadKeyboardLayout", "str", sID, "uint", 1), ctl)
}

getIMEState(winTitle := "A") {
    if !(idWIn := WinExist(winTitle))
        return
    DefaultIMEWnd := dllcall("imm32\ImmGetDefaultIMEWnd", "uint", idWin, "uint")
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows true
    res := SendMessage(WM_IME_CONTROL := 0x283, IMC_GETOPENSTATUS := 5, , , "ahk_id " . DefaultIMEWnd)
    DetectHiddenWindows DetectSave
    return res
}