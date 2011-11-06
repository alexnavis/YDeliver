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
    New-Website -Name $label -PhysicalPath $path -Force

    return $true
}

task Website {
    if ($installConfig.HasErrors) { return }
    Install-IISWebApp $installConfig.website
}
