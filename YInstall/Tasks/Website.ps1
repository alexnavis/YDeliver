function global:Install-IISWebApp {
    param($config)

    if ($config.HasErrors) { return $false }

    return $true
}

task Website {

}
