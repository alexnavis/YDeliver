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

function Get-Plugin {
    param ($name, $file)
    if (Test-Path $file) {
        Remove-Item $file | Out-Null
    }
    (new-object Net.WebClient).DownloadFile("https://github.com/$name/zipball/master", $file)
}

function Unzip-File {
    param($source, $destination, $7z)
    if ($destination -ne "") {
        Remove-Item $destination -Recurse -ErrorAction silentlycontinue
        $destination = "-o" + $destination 
    }
    &$7z x -y $source $destination 
}

function Install-YPlugin {
    [CmdletBinding()]
    param($name, $rootDir = $pwd)

    # some hackery to provide the rootDir to Install.Tasks.ps1
    $global:rootDir = $rootDir
    . "$PSScriptRoot\Conventions\Defaults.ps1"

    $temp_file = "$($env:Temp)\ydeliver-plugin.zip"
    $temp_extracted = "$($env:Temp)\ydeliver-plugin"
    Get-Plugin $name $temp_file

    if (Test-Path $temp_extracted) {
        Remove-Item $temp_extracted -Recurse -Force
    }

    $7z = "$PSScriptRoot\Lib\7z\7za.exe"
    Unzip-File $temp_file $temp_extracted $7z

    $extract_dir = (Resolve-Path "$temp_extracted\*").Path 
    copy $extract_dir\*.ps1 $PSScriptRoot\YBuild\Tasks

    if (Test-Path $extract_dir\packages.config) {
        nuget install $extract_dir\packages.config -OutputDirectory $conventions.toolsPath -ExcludeVersion
    }
}

Export-ModuleMember Invoke-YBuild, Invoke-YInstall, Install-YPlugin
