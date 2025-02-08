' Create a simple text-based progress bar
Set objShell = CreateObject("WScript.Shell")

' Get the path of the directory containing this VBScript
scriptPath = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)

' Total number of batch files to run (in relative paths)
BatchFiles = Array( _ 
    scriptPath & "\BATCH000.bat", _ 
    scriptPath & "\BATCH100_BOTH.bat", _ 
    scriptPath & "\BATCH200.bat", _ 
    scriptPath & "\..\schema\create_schemas.bat", _ 
    scriptPath & "\992_PROD_Flask_Build_and_Start.bat", _ 
    scriptPath & "\992_PROD_Flask_Sever_Details.bat", _ 
    scriptPath & "\991_PROD_WebClient_Build.bat", _ 
    scriptPath & "\991_PROD_WebClient_Start.bat", _ 
    scriptPath & "\991_PROD_WebClient_Details.bat" _
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
