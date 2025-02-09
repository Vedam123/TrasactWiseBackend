' Create a simple text-based progress bar
Set objShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Get the path of the directory containing this VBScript
scriptPath = fso.GetParentFolderName(WScript.ScriptFullName)

' Define batch files with their respective directories
BatchFiles = Array( _
    Array(scriptPath, "BATCH000.bat"), _ 
    Array(scriptPath, "BATCH100_BOTH.bat"), _ 
    Array(scriptPath, "BATCH200.bat"), _ 
    Array(fso.GetAbsolutePathName(scriptPath & "\..\schema"), "create_schemas_bat.bat"), _ 
    Array(scriptPath, "992_PROD_Flask_Build_and_Start.bat"), _ 
    Array(scriptPath, "992_PROD_Flask_Sever_Details.bat"), _ 
    Array(scriptPath, "991_PROD_WebClient_Build.bat"), _ 
    Array(scriptPath, "991_PROD_WebClient_Start.bat"), _ 
    Array(scriptPath, "991_PROD_WebClient_Details.bat") _
)

TotalFiles = UBound(BatchFiles) + 1

' Store the current directory
originalDir = objShell.CurrentDirectory
' WScript.Echo "Original Directory: " & originalDir

' Run each batch file in sequence
For i = 0 To UBound(BatchFiles)
    batchDir = BatchFiles(i)(0)
    batchFile = BatchFiles(i)(1)
    batchFilePath = batchDir & "\" & batchFile

    ' Debugging - Show paths
    ' WScript.Echo "------------------------------------"
    ' WScript.Echo "Processing: " & batchFile
    ' WScript.Echo "Batch Directory: " & batchDir
    ' WScript.Echo "Resolved Batch File Path: " & batchFilePath

    ' Ensure the batch file exists
    If Not fso.FileExists(batchFilePath) Then
        WScript.Echo "ERROR: Batch file not found: " & batchFilePath
        WScript.Echo "Skipping..."
    Else
        ' Change to the batch file directory
        objShell.CurrentDirectory = batchDir
        ' WScript.Echo "Switched to Directory: " & batchDir

        ' Execute the batch file
        cmdCommand = "cmd /c ""cd /d " & batchDir & " && " & batchFile & """"
        ' WScript.Echo "Executing Command: " & cmdCommand
        returnCode = objShell.Run(cmdCommand, 1, True) ' Set 1 to show the command window

        ' Debugging: Check return code
        ' WScript.Echo "Return Code: " & returnCode
        If returnCode <> 0 Then
            WScript.Echo "ERROR: Batch script execution failed with return code " & returnCode
        End If

        ' Update progress (calculate percentage)
        progress = Int(((i + 1) / TotalFiles) * 100)
        objShell.Popup "Progress: " & progress & "%", 1, "Progress", 64
    End If
Next

' Switch back to the original directory
objShell.CurrentDirectory = originalDir
'WScript.Echo "Switched Back to Original Directory: " & originalDir

' Completion message
objShell.Popup "All batch scripts executed successfully!", 3, "Finished", 64
