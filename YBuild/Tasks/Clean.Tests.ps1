$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")

function Task { }

. "$here\$sut"

Describe "Clean-RootOfBuildArtifacts" {

    Setup -File "project\bin\Release\foo.dll"
    Setup -File "project\obj\Release\foo.dll"

    Setup -File "webproject\bin\foo.dll"

    Setup -Dir "build\package"

    It "should remove the projects build directory" {
        Clean-RootOfBuildArtifacts $TestDrive $TestDrive\build
        $build_dir_exists = Test-Path $TestDrive\build
        $build_dir_exists.should.be($false)
    }

    It "should cleanup the bin directory of a web project" {
        $deleted_file = "$TestDrive\webproject\bin\foo.dll"
        (Test-Path $deleted_file).should.be($false)
    }

    It "should also remove dlls from bin directories" {
        $dll_exists = Test-Path $TestDrive\project\bin\Release\foo.dll
        $dll_exists.should.be($false)
    }

    It "should also remove dlls from obj directories" {
        $dll_exists = Test-Path $TestDrive\project\obj\Release\foo.dll
        $dll_exists.should.be($false)
    }
}
