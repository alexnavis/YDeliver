@echo off
@powershell -ExecutionPolicy RemoteSigned Import-Module .\..\YDeliver.psm1; Invoke-YInstall Website
