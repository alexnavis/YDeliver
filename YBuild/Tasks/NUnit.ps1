task NUnit {
    $toolsPath, $buildPath, $unitTestPathPattern = Get-Conventions toolsPath, buildPath, unitTestPathPattern

    if (-not (Test-Path $buildPath)) {
        md $buildPath | Out-Null
    }

    Write-Host "echoing... $unitTestPathPattern"
    Get-ChildItem "$rootDir\$unitTestPathPattern\*.csproj" | %{
        $testProjects += "$(split-path $_.fullname)\bin\Debug\$([system.io.path]::GetFilenameWithoutExtension($_.name)).dll "
    }

    $nunit = "$toolsPath\nunit\nunit-console.exe"
    exec { iex "$nunit $testProjects /xml=$buildPath\UnitTest-Results.xml" } "Unit tests failed"
}
