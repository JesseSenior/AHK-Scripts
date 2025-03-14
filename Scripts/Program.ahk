/*
Copyright (C) 2021-2025 Jesse Senior. All rights reserved.

Author : Jesse Senior <jessesenior@qq.com>
Note   : 应用程序.
*/
#Requires AutoHotkey v2.0
#Include IncludeCommon.ahk

; Keepass
XButton2 & k::
RControl & k:: Run Settings.KeePassPath
if !FileExist(Settings.KeePassPath) {
    Hotkey("XButton2 & k", "Off")
    Hotkey("RControl & k", "Off")
}

; Keepass Auto Input
^!a::
XButton2 & a::
{
    toIME()
    Send "^!+a"

    if WinWait("ahk_exe CredentialUIBroker.exe", , 0.2) {
        ;if WinActive
        ;    return
        WinActivate
        WinWaitClose
        if WinWait("AutoTypeSearch", , 1)
            WinActivate
    }
    else if WinWait("AutoTypeSearch", , 0.2) {
        ;if WinActive
        ;    return
        WinActivate
    }
}
if !FileExist(Settings.KeePassPath) {
    Hotkey("^!a", "Off")
    Hotkey("XButton2 & a", "Off")
}

; Windows Terminal
XButton2 & w::
RControl & w:: Run "wt"

; Windows File Explorer
XButton2 & e::
RControl & e:: Send "#e"

; Everything
XButton2 & s::
RControl & s::
{
    Run Settings.EverythingPath
    if WinWait("ahk_class EVERYTHING", , 0.2)
        WinActivate
}
if !FileExist(Settings.EverythingPath) {
    Hotkey("XButton2 & s", "Off")
    Hotkey("RControl & s", "Off")
}

; Browser
XButton2 & c::
RControl & c:: Run Settings.BrowserPath
if !FileExist(Settings.BrowserPath) {
    Hotkey("XButton2 & c", "Off")
    Hotkey("RControl & c", "Off")
}

; Obsidian
XButton2 & g::
RControl & g:: Run Settings.ObsidianPath
if !FileExist(Settings.ObsidianPath) {
    Hotkey("XButton2 & g", "Off")
    Hotkey("RControl & g", "Off")
}

; Microsoft Visual Studio Code
XButton2 & v::
RControl & v:: Run Settings.VSCodePath
if !FileExist(Settings.VSCodePath) {
    Hotkey("XButton2 & v", "Off")
    Hotkey("RControl & v", "Off")
}

; Zotero
XButton2 & z::
RControl & z:: Run Settings.ZoteroPath
if !FileExist(Settings.ZoteroPath) {
    Hotkey("XButton2 & z", "Off")
    Hotkey("RControl & z", "Off")
}