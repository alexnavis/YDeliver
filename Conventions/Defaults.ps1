$conventions = @{}
$conventions.framework = "4.0x64"
$conventions.buildPath = "$rootDir\build"
$conventions.packagePath = "$($conventions.buildPath)\package"
$conventions.solutionFile = (Resolve-Path $rootDir\*.sln)
$conventions.toolsPath = "$rootDir\lib"
$conventions.inetpubPrefix = "C:"
$conventions.unitTestPathPattern = "*Unit.Tests"

# TODO remove this hack eventually
if (Test-Path $rootDir\convention.overrides.ps1) {
    . "$rootDir\convention.overrides.ps1"
}

"Conventions being used:" 
"rootDir`t`t: $rootDir"
$conventions.keys | % {
    "$_`t: $($conventions.$_)"
}
""
