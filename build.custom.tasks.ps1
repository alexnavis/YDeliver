task ArrangePackage {
    $buildPath, $packagePath = Get-Conventions buildPath, packagePath
    if (Test-Path $buildPath) { Remove-Item $buildPath -Recurse -Force }
    Copy-Item -Recurse $rootDir\CommonFunctions $packagePath\tools\CommonFunctions
    Copy-Item -Recurse $rootDir\Config $packagePath\tools\Config
    Copy-Item -Recurse $rootDir\Lib\PSake $packagePath\tools\Lib\PSake
    Copy-Item -Recurse $rootDir\YBuild $packagePath\tools\YBuild
    Copy-Item $rootDir\*.psm1 $packagePath\tools\
}

task NugetPackage {
    $buildPath, $packagePath, $toolsPath = Get-Conventions buildPath, packagePath, toolsPath
    $nuspec = (Resolve-Path $rootDir\*.nuspec)
    $nuget = "$toolsPath\Nuget\Nuget.exe"
    & $nuget pack $nuspec -BasePath $packagePath -Version $buildVersion -OutputDirectory $buildPath
}
