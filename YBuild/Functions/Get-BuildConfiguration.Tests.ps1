$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Import-Module "$here\..\..\lib\PowerYaml\PowerYaml.psm1" -Force

Describe "Get-BuildConfiguration" {

    Setup -File "with\build.yml" "a: b"
    Setup -Dir "without"

    It "returns an empty hash when no build.yml exists" {
        $config = Get-BuildConfiguration $TestDrive\without
        $config.keys.count.should.be(0)
    }

    It "returns contents of build.yml as a powershell object" {
        $config = Get-BuildConfiguration $TestDrive\with
        $config.keys.count.should.be(1)
    }

}
