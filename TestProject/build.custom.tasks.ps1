task HelloWorld {
    "Hello World!" | Write-Host
}

task XUnitTest {
    $toolsPath, $buildPath = Get-Conventions toolsPath, buildPath

    Get-ChildItem "$rootDir\*Unit.Tests\*.csproj" | %{
        $testProjects += "$(split-path $_.fullname)\bin\Release\$([system.io.path]::GetFilenameWithoutExtension($_.name)).dll "
    }

    $xunit = "$toolsPath\xunit-1.8\xunit.console.clr4.exe"
    exec { iex "$xunit $testProjects /xml $buildPath\XUnitTest-Results.xml" } "Unit tests failed"
}

