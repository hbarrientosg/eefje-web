$config.buildFileName="default.ps1"
$config.taskNameFormat="Executing {0}"
$config.verboseError= $false
$config.coloredOutput = $true
$config.taskNameFormat= { param($taskName) "Executing $taskName at $(get-date)" }
