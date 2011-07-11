
function Remove-ItemIfExists($item) {
    if (Test-Path $item) {
        Remove-Item $item -Recurse -Force
    }
}

function Cleanup() {
    Remove-ItemIfExists ".\TestProject\lib\YDeliver"
    Remove-ItemIfExists ".\TestProject\build.ps1"
    Remove-ItemIfExists ".\TestProject\build.yml"
}

function Copy-Libs() {
    Copy-Item -Recurse .\scripts .\TestProject\lib\YDeliver
    Copy-Item TestProject.build.ps1 .\TestProject\build.ps1
    Copy-Item TestProject.build.yml .\TestProject\build.yml
}

Cleanup
Copy-Libs

pushd TestProject
. .\build.ps1
popd
