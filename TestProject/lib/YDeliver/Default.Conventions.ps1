$ybc = @{}
$ybc.buildPath = "$rootDir\build"
$ybc.packagePath = "$($ybc.buildPath)\package"
$ybc.solutionFile = (Resolve-Path $rootDir\*.sln)
$ybc.toolsPath = "$rootDir\lib"

function Import-ConventionOverrides {
    if (Test-Path "$rootDir\build.conventions.ps1") {
        Write-Host Importing overriding build conventions
        . "$rootDir\build.conventions.ps1"
    }
}
