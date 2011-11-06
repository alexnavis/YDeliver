
function global:Install-IISWebApp {

    param($config)

    if ($config.HasErrors) { return $false }

    New-Website -Name $config.label -PhysicalPath $config.source -Force

    return $true
}

task Website {

}
