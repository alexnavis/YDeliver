function Get-Conventions($conventions, [switch] $noexit) {

    $conventions | % {
        if ($ybc.$_ -eq $null) {
            "Missing convention: $_ Please update your .\build.ps1 to have a value for `$ybc.$_" | Write-Host 
            if (-not $noexit) {
                cd $rootDir
                exit 1
            }
        }
        $ybc.$_
    }

}
