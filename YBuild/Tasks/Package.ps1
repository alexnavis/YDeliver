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
    $buildPath,$packagePath = Get-Conventions buildPath,packagePath

    if ($buildConfig.HasErrors) { Write-PackageHelp; return }

    if (-not (Test-Path $packagePath)) {
        md $packagePath | Out-Null
    }

    foreach($source in $($buildConfig.packageContents).keys){
        Copy-ArtifactItem "$rootDir\$source" "$($packagePath)\$($buildConfig.packageContents[$source])"
    }
}
