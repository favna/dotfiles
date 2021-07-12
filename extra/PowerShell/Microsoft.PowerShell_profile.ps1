$currentDirectory = (Get-ChildItem $MyInvocation.MyCommand.Path).Directory.FullName;
$functionsDirectory = "$currentDirectory\functions";
$completionsDirectory = "$currentDirectory\completions";

$Env:STARSHIP_CONFIG = "$currentDirectory\starship.toml"

Import-Module -Name posh-git
Import-Module -Name Terminal-Icons

Invoke-Expression (&starship init powershell)

. $functionsDirectory\Git-Functions.ps1
. $functionsDirectory\GitHub-Cli-Functions.ps1
. $functionsDirectory\NodeJS-Functions.ps1
. $functionsDirectory\Terminal-Functions.ps1
. $functionsDirectory\Video-Functions.ps1
. $functionsDirectory\Custom-Aliases.ps1

& "$completionsDirectory\Starship-Completions.ps1"
& "$completionsDirectory\Gh-Completions.ps1"
& "$completionsDirectory\Custom-Completions.ps1"
