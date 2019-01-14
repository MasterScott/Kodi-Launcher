#NoTrayIcon

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Kodi.ico
#AutoIt3Wrapper_Outfile=Kodi Launcher.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UPX_Parameters=-9 --strip-relocs=0 --compress-exports=0 --compress-icons=0
#AutoIt3Wrapper_Res_Description=Kodi Launcher
#AutoIt3Wrapper_Res_Fileversion=1.0.0.47
#AutoIt3Wrapper_Res_ProductVersion=1.0.0.47
#AutoIt3Wrapper_Res_LegalCopyright=2016, SalFisher47
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Res_SaveSource=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#Region ;**** Pragma Compile ****
#pragma compile(AutoItExecuteAllowed, true)
#pragma compile(Compression, 9)
#pragma compile(Compatibility, vista, win7, win8, win81, win10)
#pragma compile(InputBoxRes, true)
#pragma compile(CompanyName, 'SalFisher47')
#pragma compile(FileDescription, 'Kodi Launcher')
#pragma compile(FileVersion, 1.0.0.47)
#pragma compile(InternalName, 'Kodi Launcher')
#pragma compile(LegalCopyright, '2016, SalFisher47')
#pragma compile(OriginalFilename, Kodi Launcher.exe)
#pragma compile(ProductName, 'Kodi Launcher')
#pragma compile(ProductVersion, 1.0.0.47)
#EndRegion ;**** Pragma Compile ****

; === UniCrack Installer.au3 =======================================================================================================
; Title .........: Kodi Launcher
; Version .......: 1.0.0.47
; AutoIt Version : 3.3.14.5
; Language ......: English
; Description ...: Kodi Launcher
; Author(s) .....: SalFisher47
; Last Modified .: January 01, 2019
; ==================================================================================================================================

#include <Array.au3>
#include <File.au3>

$Ini = @ScriptDir & "\" & StringTrimRight(@ScriptName, 4) & ".ini"

$kodi_exe_run = IniRead($Ini, "Settings", "kodi_exe", "")
$kodi_exe_path_full = @ScriptDir & "\" & $kodi_exe_run
$kodi_exe_only = StringTrimLeft($kodi_exe_path_full, StringInStr($kodi_exe_path_full, "\", 0, -1))
$kodi_exe_path_only = StringTrimRight($kodi_exe_path_full, StringLen($kodi_exe_only)+1)
$kodi_exe_cmd = IniRead($Ini, "Settings", "kodi_cmd", "")

$sources_xml = FileOpen(@ScriptDir & "\Kodi\portable_data\userdata\sources.xml", 0)
$sources_xml_line = FileReadToArray($sources_xml)
FileClose($sources_xml)

Local $sources_xml_line_new[1]

For $i = 0 to UBound($sources_xml_line) - 1
	If StringInStr($sources_xml_line[$i], ":\", 0) Then
		If StringMid($sources_xml_line[$i], StringInStr($sources_xml_line[$i], ":\", 0) - 1, 1) <> StringLeft(@ScriptDir, 1) Then
			_ArrayAdd($sources_xml_line_new, StringReplace($sources_xml_line[$i], StringInStr($sources_xml_line[$i], ":\", 0) - 1, StringLeft(@ScriptDir, 1)))
		Else
			_ArrayAdd($sources_xml_line_new, $sources_xml_line[$i])
		EndIf
	Else
		_ArrayAdd($sources_xml_line_new, $sources_xml_line[$i])
	EndIf
Next

FileDelete(@ScriptDir & "\Kodi\portable_data\userdata\sources.xml")

For $j = 1 to UBound($sources_xml_line_new) - 1
	$sources_xml = FileOpen(@ScriptDir & "\Kodi\portable_data\userdata\sources.xml", 1)
	FileWriteLine($sources_xml, $sources_xml_line_new[$j])
	FileClose($sources_xml)
Next

ShellExecute($kodi_exe_path_full, " " & $kodi_exe_cmd & " " & $CmdLineRaw, $kodi_exe_path_only)

