$pwd = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")

# Added dummy Task function to remove PSake requirement
function Task { }

. "$pwd\$sut"
. "$pwd\..\..\..\lib\Pester\Pester.ps1"


Describe "Clean-RootOfBuildArtifacts" {

    Setup -File "project\bin\Release\foo.dll"
    Setup -File "project\obj\Release\foo.dll"

    Setup -Dir "build\package"

    It "should remove files in bin and obj directories" {
        Clean-RootOfBuildArtifacts $TestDrive "$TestDrive\build"
        -not "$TestDrive\project\bin\Release\foo.dll".should.exist()
        -not "$TestDrive\project\obj\Release\foo.dll".should.exist()
        -not "$TestDrive\build".should.exist()
    }
}
