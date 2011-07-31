$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Get-Conventions" {

    $ybc = @{}
    $ybc.known_convention = "exist"

    It "should return the value of a known convention" {
        $convention = Get-Conventions known_convention
        $convention.should.be("exist")
    }

    It "should write an error if it could not find the convention" {
        Get-Conventions unknown -NoExit
        $(Get-ConsoleText).should.match("Missing convention")
    }
}
