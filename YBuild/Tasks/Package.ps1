function global:Copy-ArtifactItem {
    param($source, $destination)

    if (Test-Path $source -PathType Container) {
        xcopy /E /I $source\*.* $destination | Out-Null
    } else {
        echo F | xcopy $source $destination | Out-Null
    }
}

function Write-PackageHelp {
    "You don't have packageContents defined in your build.yml. That's sort of odd" | Write-Host
}

task Package {
    $buildPath,$packagePath,$toolsPath,$solutionFile = Get-Conventions buildPath,packagePath,toolsPath,solutionFile

    if ($buildConfig.packageContents -eq $null) {
        Write-PackageHelp
        return
    }

    if (-not (Test-Path $packagePath)) {
        md $packagePath | Out-Null
    }

    foreach($source in $($buildConfig.packageContents).keys){
        Copy-ArtifactItem "$rootDir\$source" "$($packagePath)\$($config.packageContents[$source])"
    }
    return
    pushd $packagePath

    $zip = "$toolsPath\7z\7za.exe"
    $zipFileName = Get-ChildItem $solutionFile | % { $_.BaseName }

    Exec { & $zip a -r $buildPath\$($zipFileName).zip * | Out-Null }

    popd
}
