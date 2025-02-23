/*
Copyright (C) 2021-2025 Jesse Senior. All rights reserved.

Author : Jesse Senior <jessesenior@qq.com>
Note   : 配置文件解析.
*/
#Requires AutoHotkey v2.0

SettingsFilePath := "%A_ScriptDir%/Settings.ini"
Settings := []

Settings.VSCodePath := IniRead(SettingsFilePath, "Settings", "VSCodePath", "C:\Users\" A_UserName "\AppData\Local\Programs\Microsoft VS Code\Code.exe")
Settings.KeePassPath := IniRead(SettingsFilePath, "Settings", "KeePassPath", "D:\Library\Portables\KeePass\KeePass.exe")
Settings.EverythingPath := IniRead(SettingsFilePath, "Settings", "EverythingPath", "C:\Users\" A_UserName "\scoop\apps\everything\current\everything.exe")
Settings.BrowserPath := IniRead(SettingsFilePath, "Settings", "BrowserPath", "C:\Users\" A_UserName "\scoop\shims\chromium.exe")
Settings.ZoteroPath := IniRead(SettingsFilePath, "Settings", "BrowserPath", "C:\Users\" A_UserName "\scoop\shims\zotero.exe")