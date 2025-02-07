Dim WshShell, processName, args
Set WshShell = CreateObject("WScript.Shell")

' Get the command-line arguments
Set args = WScript.Arguments

' Check if an argument was provided
If args.Count > 0 Then
    processName = args(0)
Else
    processName = "DefaultProcessName" ' Fallback name
End If

' Start the app.exe with the process name passed as parameter and without opening a window
WshShell.Run "app.exe " & processName, 0, False
