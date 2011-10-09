@echo off
if "%BUILD_NUMBER%"=="" (
    set BUILD_NUMBER=1.0.0
)

@powershell -ExecutionPolicy RemoteSigned Import-Module .\tools\YDeliver.psm1; ^
Invoke-YBuild NugetPackage -buildVersion %BUILD_NUMBER%
