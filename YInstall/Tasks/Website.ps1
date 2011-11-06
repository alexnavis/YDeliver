if ( @(Get-Module | ? { $_.Name -eq "webadministration" }).count -eq 0 ) {
    Import-Module webadministration
}

function global:Copy-Website {
    param($label, $source)
    $inetpubPrefix = Get-Conventions inetpubPrefix
    $websitePath = "$inetpubPrefix\inetpub\wwwroot\$label"
    Copy-Item $source $websitePath -Force -Recurse
    $websitePath
}

function global:Install-IISWebApp {
    param($label, $path)

    # TODO figure out if -Force is the best way to handle the site existing
    New-Website -Name $label -PhysicalPath $path -ApplicationPool "ASP.NET v4.0" -Force 

    return $true
}

task Website {
    if ($installConfig.HasErrors) { return }

    $config = $installConfig.website
    $websitePath = Copy-Website $config.label "$rootDir\$($config.source)"
    Install-IISWebApp $config.label $websitePath 

    Start-Website $config.label
}
