$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")

function Task { }
. "$here\$sut"

Describe "Install-IISWebApp" {

    It "fails fast if an install configuration does not exist" {
        $success = Install-IISWebApp @{ HasErrors = $true } 
        $success.should.be($false)
    }
}
