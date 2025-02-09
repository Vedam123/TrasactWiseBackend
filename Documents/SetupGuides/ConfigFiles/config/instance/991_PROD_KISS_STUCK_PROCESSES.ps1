# kill-process.ps1

param (
    [string]$keyword  # The keyword to search for in the CommandLine
)

# Find the process that matches the keyword in the command line
$process = Get-WmiObject Win32_Process | Where-Object { $_.Name -eq "node.exe" -and $_.CommandLine -match $keyword }

# If a process is found, kill it with force
if ($process) {
    $processId = $process.ProcessId
    Write-Host "Found process with ProcessId: $processId"
    # Force kill the process
    Stop-Process -Id $processId -Force
    Write-Host "Process with ProcessId $processId has been killed with force."
} else {
    Write-Host "No process found with keyword '$keyword'."
}
