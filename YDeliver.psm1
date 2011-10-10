Import-Module "$PSScriptRoot\lib\PSake\psake.psm1" -Force

function Invoke-YBuild {
    [CmdletBinding()]
    param($tasks, $buildVersion = "1.0.0", $rootDir = $pwd)

    # some hackery to provide the rootDir to Build.Tasks.ps1
    $global:rootDir = $rootDir
    . "$PSScriptRoot\Config\Default.Conventions.ps1"

    Invoke-Psake "$PSScriptRoot\YBuild\Build.Tasks.ps1" `
        -framework "4.0x64" `
        -taskList $tasks `
        -parameters @{
            "buildVersion" = $buildVersion;
            "ybc" = $ybc;
            "rootDir" = $rootDir;
          }
}

Export-ModuleMember Invoke-YBuild
