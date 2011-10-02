Import-Module "$PSScriptRoot\lib\PSake\psake.psm1" -Force
Import-Module "$PSScriptRoot\lib\PowerYaml\PowerYaml.psm1" -Force

function Invoke-YBuild {
    [CmdletBinding()]
    param($tasks, $buildVersion = "1.0.0", $rootDir = $pwd)

    . "$PSScriptRoot\Config\Default.Conventions.ps1"
    $config = Get-Yaml -FromFile "$rootDir\build.yml"

    Invoke-Psake "$PSScriptRoot\YBuild\Build.Tasks.ps1" `
        -framework $config.dotnet.framework_version `
        -taskList $tasks `
        -parameters @{
            "buildVersion" = $buildVersion;
            "ybc" = $ybc;
            "config" = $config;
            "rootDir" = $rootDir;
          }
}

Export-ModuleMember Invoke-YBuild
