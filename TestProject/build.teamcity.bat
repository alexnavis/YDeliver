@echo off
if "%BUILD_NUMBER%"=="" (
    set BUILD_NUMBER=1.0.0
)

@powershell set-executionpolicy remotesigned
@powershell .\build.ps1 -buildVersion %BUILD_NUMBER%

