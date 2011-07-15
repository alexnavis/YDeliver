param(
    # The following Tasks will be exuted serially. The build process must be explicitly
    # listed here. No auto task dependency resolution is going on here.
    $task = @("Clean", "Compile", "UnitTest", "Package", "HelloWorld"),

    # By default the build version is what is automatically populated by Visual Studio in an
    # AssemblyInfo.cs file. This can be overridden by a CI server by passing the -buildVersion arg
    $buildVersion = "1.0.0"
)

# One root dir to rule them all and in global scope bind them!
$global:rootDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Could add some smarts to this to find YDeliver automagically
$ydeliverPath = "$rootDir\lib\YDeliver"

# Need import default build conventions
. "$ydeliverPath\Default.Conventions.ps1"

# import convention overrides in $rootDir\build.conventions.ps1 if they exists
Import-ConventionOverrides

# all of our ducks are in a row, it's time to build!
. "$ydeliverPath\YBuild\Execute.ps1"
