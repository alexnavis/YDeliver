$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Import-Module "$here\YDeliver.psm1" -Force

Describe "YBuild" {

    It "does not completely fall on its face" {
        Invoke-YBuild | Out-Null
        # TODO need a way to track if an error occurs
    }
}

Describe "YInstall" {

    It "does not completely fall on its face" {
        Invoke-YInstall | Out-Null
        # TODO need a way to track if an error occurs
    }
}
