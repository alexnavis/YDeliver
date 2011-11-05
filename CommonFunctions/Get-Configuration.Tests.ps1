$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Import-Module "$here\..\lib\PowerYaml\PowerYaml.psm1" -Force

Describe "Get-Configuration" {
    Setup -File "foo.yml" "test: awesome"

    It "returns an empty hash when no build.yml exists" {
        $config = Get-Configuration -Path $TestDrive -Name build 
        $config.keys.count.should.be(0)
    }

    It "returns the contents of the specified yml file" {
        $config = Get-Configuration -Path $TestDrive -Name foo
        $config.test.should.be("awesome")
    }
}

Describe "Get-BuildConfiguration" {

    Setup -File "build.yml" "a: b"

    It "returns contents of build.yml as a powershell object" {
        $config = Get-BuildConfiguration $TestDrive
        $config.keys.count.should.be(1)
    }

}

Describe "Get-InstallConfiguration" {

    Setup -File "install.yml" "a: b"

    It "returns contents of install.yml as a powershell object" {
        $config = Get-InstallConfiguration $TestDrive
        $config.keys.count.should.be(1)
    }

}
