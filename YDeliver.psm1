Import-Module "$PSScriptRoot\lib\PSake\psake.psm1" -Force
Import-Module "$PSScriptRoot\lib\PowerYaml\PowerYaml.psm1" -Force
. "$PSScriptRoot\CommonFunctions\Get-Configuration.ps1"



function Invoke-YBuild {
    [CmdletBinding()]
    param([string[]] $tasks = @('Help'), $buildVersion = "1.0.0", $rootDir = $pwd)

    # some hackery to provide the rootDir to Build.Tasks.ps1
    $global:rootDir = $rootDir
    . "$PSScriptRoot\Conventions\Defaults.ps1"

    Invoke-Psake "$PSScriptRoot\YBuild\Build.Tasks.ps1" `
        -framework $conventions.framework `
        -taskList $tasks `
        -parameters @{
            "buildVersion" = $buildVersion;
            "buildConfig" =  (Get-BuildConfiguration $rootDir); 
            "conventions" = $conventions;
            "rootDir" = $rootDir;
          }
}

function Invoke-YInstall {
    [CmdletBinding()]
    param([string[]] $tasks = @('Help'), $rootDir = $pwd)

    # some hackery to provide the rootDir to Install.Tasks.ps1
    $global:rootDir = $rootDir
    . "$PSScriptRoot\Conventions\Defaults.ps1"

    Invoke-Psake "$PSScriptRoot\YInstall\Install.Tasks.ps1" `
        -taskList $tasks `
        -parameters @{
            "installConfig" = (Get-InstallConfiguration $rootDir);
            "conventions" = $conventions;
            "rootDir" = $rootDir;
          }
}
Export-ModuleMember Invoke-YBuild, Invoke-YInstall
