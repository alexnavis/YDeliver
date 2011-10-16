$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Get-Conventions" {

    $conventions = @{}
    $conventions.known_convention = "exist"
    $conventions.other_known_convention = "exist"

    It "should return the value of a known convention" {
        $convention = Get-Conventions known_convention
        $convention.should.be("exist")
    }

    It "should return all conventions asked for" {
        $resolved = Get-Conventions known_convention, other_known_convention
        $resolved.length.should.be(2)
    }
}
