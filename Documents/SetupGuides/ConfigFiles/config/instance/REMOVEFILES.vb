' Create a simple text-based progress bar
Set objShell = CreateObject("WScript.Shell")

' Get the path of the directory containing this VBScript
scriptPath = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)

' Total number of batch files to run (in relative paths)
BatchFiles = Array( _ 
    scriptPath & "\992_PROD_Flask_Server_Stop.bat", _ 
    scriptPath & "\991_PROD_WebClient_Stop.bat", _ 
    scriptPath & "\801_stop_services.bat", _ 
    scriptPath & "\802_Remove_services.bat", _ 
)

TotalFiles = UBound(BatchFiles) + 1

' Run each batch file in sequence
For i = 0 To UBound(BatchFiles)
    ' Run batch file using WScript
    objShell.Run "cmd /c """ & BatchFiles(i) & """", 0, True
    
    ' Update progress (calculate percentage)
    progress = Int(((i + 1) / TotalFiles) * 100)
    
    ' Display progress using Popup (simple text-based)
    objShell.Popup "Progress: " & progress & "%", 1, "Progress", 64
Next

' Once all are done
objShell.Popup "All batch scripts have been executed successfully!", 3, "Finished", 64
