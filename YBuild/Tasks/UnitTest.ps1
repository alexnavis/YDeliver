task UnitTest {
    $toolsPath, $buildPath = Get-Conventions toolsPath, buildPath

    Get-ChildItem "$rootDir\*Unit.Tests\*.csproj" | %{
        $testProjects += "$(split-path $_.fullname)\bin\Release\$([system.io.path]::GetFilenameWithoutExtension($_.name)).dll "
    }

    $nunit = "$toolsPath\nunit\nunit-console.exe"
    exec { iex "$nunit $testProjects /xml=$buildPath\UnitTest-Results.xml" } "Unit tests failed"
}
