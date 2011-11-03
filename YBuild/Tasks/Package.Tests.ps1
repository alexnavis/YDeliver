$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")

function Task { }

. "$here\$sut"

Describe "Copy-ArtifactItem" {

    Context "Copying directories" {
        Setup -File "source\foo\bar\biz.txt"
        Setup -Dir  "destination"

        It "copies the directory and all it's contents into the destination" {
            Copy-ArtifactItem "$TestDrive\source\foo" "$TestDrive\destination\foo" 
            "$TestDrive\destination\foo\bar\biz.txt".should.exist()
        }
    }

    Context "Copying individual files" {
        Setup -File "source\foo.txt"
        Setup -Dir  "destination"

        It "copies the file into the destination directory" {
            Copy-ArtifactItem "$TestDrive\source\foo.txt" "$TestDrive\destination"
            "$TestDrive\destination\foo.txt".should.exist()
        }
    }
}
