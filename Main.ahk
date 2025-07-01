/*
Copyright (C) 2021-2025 Jesse Senior. All rights reserved.

Author : Jesse Senior <jessesenior@qq.com>
Note   : 主程序.
*/
#Requires AutoHotkey v2 64-bit

#NoTrayIcon
#SingleInstance

A_MaxHotkeysPerInterval := 200    ; 快速键入支持
InstallKeybdHook
SetWorkingDir A_Desktop    ; 确保起始目录一致。
ProcessSetPriority "High"

SetWinDelay -1
SetControlDelay -1

; 打开NumLock开关
SetNumLockState True

;Pause::Pause -1

; 特定组下屏蔽指令
GroupAdd "RemoteAccess", "ahk_exe mstsc.exe"
GroupAdd "RemoteAccess", "ahk_exe vmconnect.exe"
; #HotIf not WinActive("ahk_group RemoteAccess")

#Include Scripts/AHKManage.ahk
#Include Scripts/Bindings.ahk
#Include Scripts/Program.ahk
#Include Scripts/Scheduler.ahk