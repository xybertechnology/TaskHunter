Get-Date
Write-Output ""
$TaskCount = 1
$ROOT = "ROOT"
$Tasks = Get-ScheduledTask | Select-Object -Property Date, TaskName, Author, TaskPath, Actions, Principal, SecurityDescriptor | Where-Object { $_.TaskPath -notmatch 'Microsoft' }
#$TaskInfo = Get-ScheduledTask | Get-ScheduledTaskInfo | Select-Object -Property LastRunTime, LastTaskResult, NumberofMissedRuns
FOREACH ($Task in $Tasks) {
    Write-Output "Querying current task data in Task Scheduler..."
    START-SLEEP -Seconds 2
    Write-Output ""
    Write-Output "Scheduled Task #$TaskCount`:"
    Write-Output ""
    IF ([STRING]::ISNULLORWHITESPACE($Task.date)) {
        Write-Output "- Date of Creation: `nNo registered data found."
    }
    ELSE {
        Write-Output "- Date of Creation: " $Task.date
    }
    Write-Output ""    
    IF ([STRING]::ISNULLORWHITESPACE($Task.taskname)) {
        Write-Output "- Task Name: `nNo registered data found."
    }
    ELSE {
        Write-Output "- Task Name: " $Task.TaskName
    }
    Write-Output ""
    IF ([STRING]::ISNULLORWHITESPACE($Task.Author)) {
        Write-Output "- Author: `nNo registered data found."
    }
    ELSE {
        Write-Output "- Author: " $Task.Author
    }
    Write-Output ""
    IF ([STRING]::ISNULLORWHITESPACE($Task.TaskPath)) {
        Write-Output "- Task Path: `nNo registered data found."
    }
    ELSEIF ($Task.TaskPath -match ("\\")) {
        $TASKPATH = -join ($ROOT, $Task.Taskpath)
        Write-Output "- Task Path: " $TASKPATH
    }
    Write-Output ""
    IF ([STRING]::ISNULLORWHITESPACE($Task.Actions.ToString())) {
        Write-Output "- Task Action: `nNo registered data found."
    }
    ELSE {
        Write-Output "- Task Action: " $Task.Actions
    }
    Write-Output ""
    IF ([STRING]::ISNULLORWHITESPACE($Task.Principal.ToString())) {
        Write-Output "- Principal (User, Group, Elevation, etc.): `nNo registered data found."
    }
    ELSE {
        Write-Output "- Principal (User, Group, Elevation, etc.): " $Task.Principal
    }
    Write-Output ""
    IF ([STRING]::ISNULLORWHITESPACE($Task.SecurityDescriptor)) {
        Write-Output "- Security Description (Access Control List, etc.): `nNo registered data found."
    }
    ELSE {
        Write-Output "- Security Description (Access Control List, etc.): " $Task.SecurityDescriptor
    }
    $TaskCount++
    Write-Output ""
    Write-Output "- Task Information (Last execution, Number of Failed Executions, etc.):"
    Get-ScheduledTaskInfo -TaskName $Task.TaskName -TaskPath $Task.TaskPath | Select-Object -Property LastRunTime, LastTaskResult, NumberofMissedRuns
}
Write-Output "All queries completed!"
Write-Output ""
PAUSE
Write-output ""
Write-Output "Terminating program..."
Start-Sleep -Seconds 2