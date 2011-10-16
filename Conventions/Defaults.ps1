$conventions = @{}
$conventions.framework = "4.0x64"
$conventions.buildPath = "$rootDir\build"
$conventions.packagePath = "$($conventions.buildPath)\package"
$conventions.solutionFile = (Resolve-Path $rootDir\*.sln)
$conventions.toolsPath = "$rootDir\lib"

"Conventions being used:" | Write-Host
$conventions.keys | % {
    "$_`t: $($conventions.$_)" | Write-Host
}
"" | Write-Host
