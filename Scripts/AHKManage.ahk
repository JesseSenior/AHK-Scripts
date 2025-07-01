/*
Copyright (C) 2021-2025 Jesse Senior. All rights reserved.

Author : Jesse Senior <jessesenior@qq.com>
Note   : 脚本管理热键.
*/
#Requires AutoHotkey v2.0
#Include IncludeCommon.ahk

#HotIf not WinActive("ahk_group RemoteAccess")
XButton1 & e::
Edit_(hk := 0)
{
    ;Edit
    if FileExist(Settings.VSCodePath)
        vscodepath := Settings.VSCodePath . " " . A_ScriptDir
    else
        vscodepath := "explorer.exe " . A_ScriptDir
    Run(vscodepath)
}

XButton1 & r::
Reload_(hk := 0)
{
    RefreshEnvironment()
    Reload
}

XButton1 & a::
ToggleTrayIcon(hk := 0)
{
    A_IconHidden := Not A_IconHidden
}

#HotIf GetKeyState("RControl") and not WinActive("ahk_group RemoteAccess")
RAlt & e:: Edit_()
RAlt & r:: Reload_()
RAlt & a:: ToggleTrayIcon()
