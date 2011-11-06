$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")

. "$here\..\..\CommonFunctions\Get-Conventions.ps1"

function Task { }
. "$here\$sut"

Describe "Copy-Website" {

    Setup -Dir "package\website\bin"

    $conventions = @{ inetpubPrefix = $TestDrive }
    It "copies files from a path relative to execution into standard IIS folders" {
        $websitePath = Copy-Website "label" "$TestDrive\package\website"
        "$TestDrive\inetpub\wwwroot\label\bin".should.exist()
    }
}

Describe "Install-IISWebApp" {

    It "will create a website with the name given in the configuration" {
        $success = Install-IISWebApp "YDeliver-Test-Website" $here 
        "IIS:\Sites\YDeliver-Test-Website".should.exist()
    }

}
