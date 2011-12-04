@echo off
if "%BUILD_NUMBER%"=="" (
    set BUILD_NUMBER=1.0.0
)

@powershell -ExecutionPolicy RemoteSigned Import-Module .\..\YDeliver.psm1; Invoke-YBuild Clean,Compile,NUnit,Package -buildVersion %BUILD_NUMBER%
