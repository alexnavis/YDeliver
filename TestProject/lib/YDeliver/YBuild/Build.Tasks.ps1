$script:dir = Split-Path -Parent $MyInvocation.MyCommand.Path
gci $script:dir\..\CommonFunctions | % { . $_.FullName }
gci $script:dir\Tasks | % { . $_.FullName }

if (Test-Path ("$rootDir\build.custom.tasks.ps1")) {
    "Importing custom tasks" | Write-Host
    . "$rootDir\build.custom.tasks.ps1"
}
