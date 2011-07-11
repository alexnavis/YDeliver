$script:dir = Split-Path -Parent $MyInvocation.MyCommand.Path
gci $script:dir\..\CommonFunctions | % { . $_.FullName }
gci $script:dir\Tasks | % { . $_.FullName }
