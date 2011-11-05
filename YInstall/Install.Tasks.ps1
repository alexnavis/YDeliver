$script:dir = Split-Path -Parent $MyInvocation.MyCommand.Path
gci $script:dir\..\CommonFunctions | ? { -not $_.FullName.EndsWith(".Tests.ps1") } | % { . $_.FullName }
gci $script:dir\Tasks | ? { -not $_.FullName.EndsWith(".Tests.ps1") } | % { . $_.FullName }

if (Test-Path ("$rootDir\install.custom.tasks.ps1")) {
    "Importing custom install tasks..." | Write-Host
    . "$rootDir\install.custom.tasks.ps1"
}
