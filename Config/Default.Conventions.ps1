$ybc = @{}
$ybc.buildPath = "$rootDir\build"
$ybc.packagePath = "$($ybc.buildPath)\package"
$ybc.solutionFile = (Resolve-Path $rootDir\*.sln)
$ybc.toolsPath = "$rootDir\lib"
