function global:Clean-RootOfBuildArtifacts($path, $buildPath) {
    Get-ChildItem $path -Include bin, obj -Recurse | %{ Remove-Item $_\* -Force -Recurse }
    Remove-Item $buildPath -Force -Recurse -ErrorAction silentlycontinue
}

task Clean {
    $buildPath, $solutionFile = Get-Conventions buildPath, solutionFile
    Exec { msbuild $solutionFile /t:clean } "Could not clean the project"
    Clean-RootOfBuildArtifacts $rootDir $buildPath
}
