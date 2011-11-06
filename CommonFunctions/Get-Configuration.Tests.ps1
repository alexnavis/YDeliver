$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Import-Module "$here\..\lib\PowerYaml\PowerYaml.psm1" -Force

Describe "Get-Configuration" {
    Setup -File "foo.yml" "test: awesome"

    It "adds a property HasNoErrors to the object it retrieves" {
        $config = Get-Configuration -Path $TestDrive -Name notthere
        ($config.HasNoErrors -eq $null).should.be($false)
    }

    It "adds a property HasErrors to the object it retrieves and it should be the opposite of HasNoErrors" {
        $config = Get-Configuration -Path $TestDrive -Name nothere
        ($config.HasErrors -eq $null).should.be($false)
        ($config.HasErrors -eq $config.HasNoErrors).should.be($false)
    }


    It "sets HasNoErrors to false if the file does not exist" {
        $config = Get-Configuration -Path $TestDrive -Name build 
        $config.HasNoErrors.should.be($false)
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
        ($config.a -ne $null).should.be($true)
    }

}

Describe "Get-InstallConfiguration" {

    Setup -File "install.yml" "a: b"

    It "returns contents of install.yml as a powershell object" {
        $config = Get-InstallConfiguration $TestDrive
        ($config.a -ne $null).should.be($true)
    }

}
