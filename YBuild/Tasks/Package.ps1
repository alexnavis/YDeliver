task Package {
    $buildPath,$packagePath,$toolsPath,$solutionFile = Get-Conventions buildPath,packagePath,toolsPath,solutionFile

    if (-not (Test-Path $packagePath)) {
        md $packagePath | Out-Null
    }

    foreach($source in $($config.packageContents).keys){
        Copy-ArtifactItem "$rootDir\$source" "$($packagePath)\$($config.packageContents[$source])"
    }

    pushd $packagePath

    $zip = "$toolsPath\7z\7za.exe"
    $zipFileName = Get-ChildItem $solutionFile | % { $_.BaseName }

    Exec { & $zip a -r $buildPath\$($zipFileName).zip * | Out-Null }

    popd
}
