task NugetPackage {
    $buildPath = Get-Conventions buildPath
    if (Test-Path $buildPath) { Remove-Item $buildPath -Recurse -Force }
    New-Item $buildPath -type Directory
    $nuspec = (Resolve-Path $rootDir\nuget\*.nuspec)
    $nuget = "$rootDir\nuget\Nuget.exe"
    & $nuget pack $nuspec -BasePath $rootDir -Version $buildVersion -OutputDirectory $buildPath
}
