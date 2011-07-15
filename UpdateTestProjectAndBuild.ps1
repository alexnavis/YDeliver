
function Remove-ItemIfExists($item) {
    if (Test-Path $item) {
        Remove-Item $item -Recurse -Force
    }
}

function Cleanup() {
    Remove-ItemIfExists ".\TestProject\lib\YDeliver"
}

function Copy-Libs() {
    Copy-Item -Recurse .\scripts .\TestProject\lib\YDeliver
}

Cleanup
Copy-Libs

pushd TestProject
. .\build.ps1
popd
