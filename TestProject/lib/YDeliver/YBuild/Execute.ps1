# Assumptions made in this script are that the conventions
# have been loaded and the projects root directory has been set

# PSake is the task execution framework being used
Import-Module "$($ybc.toolsPath)\PSake\psake.psm1" -force

# PowerYaml is needed to load the YAML build file
Import-Module "$($ybc.toolsPath)\PowerYaml\PowerYaml.psm1" -force

$config = Get-Yaml -FromFile "$rootDir\build.yml"

# Here's where the build is actually executed
Invoke-Psake "$($ybc.toolsPath)\YDeliver\YBuild\Build.Tasks.ps1" `
    -framework $config.dotnet.framework_version `
    -taskList $task `
    -parameters @{
        "buildVersion" = $buildVersion;
        "ybc" = $ybc;
        "config" = $config;
        "rootDir" = $rootDir;
      }
