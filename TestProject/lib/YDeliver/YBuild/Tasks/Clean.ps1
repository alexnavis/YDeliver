task Clean {
    $buildPath, $solutionFile = Get-Conventions buildPath, solutionFile

    # Thinking of making bin, obj folders a convention
    Get-ChildItem $rootDir -Include bin, obj -Recurse | %{ Remove-Item $_\* -Force -Recurse }
    Remove-Item $buildPath -Force -Recurse -ErrorAction silentlycontinue

    Exec { msbuild $solutionFile /t:clean } "Could not clean the project"
    Exec { mkdir $buildPath | Out-Null }
}
