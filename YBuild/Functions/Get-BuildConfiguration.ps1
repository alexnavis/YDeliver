function Get-BuildConfiguration {
    param($path)
    $buildConfig = @{}
    if (Test-Path $path\build.yml) {
       $buildConfig = Get-Yaml -FromFile $path\build.yml 
    }
    $buildConfig
}
