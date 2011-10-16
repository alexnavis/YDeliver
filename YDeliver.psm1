Import-Module "$PSScriptRoot\lib\PSake\psake.psm1" -Force

function Invoke-YBuild {
    [CmdletBinding()]
    param($tasks, $buildVersion = "1.0.0", $rootDir = $pwd)

    # some hackery to provide the rootDir to Build.Tasks.ps1
    $global:rootDir = $rootDir
    . "$PSScriptRoot\Conventions\Defaults.ps1"

    Invoke-Psake "$PSScriptRoot\YBuild\Build.Tasks.ps1" `
        -framework $conventions.framework `
        -taskList $tasks `
        -parameters @{
            "buildVersion" = $buildVersion;
            "conventions" = $conventions;
            "rootDir" = $rootDir;
          }
}

Export-ModuleMember Invoke-YBuild
