$currentDirectory = (Get-ChildItem $MyInvocation.MyCommand.Path).Directory.FullName;
$functionsDirectory = "$currentDirectory\functions";
$completionsDirectory = "$currentDirectory\completions";
$aliasesDirectory = "$currentDirectory\aliases";

$Env:STARSHIP_CONFIG = "$currentDirectory\starship.toml"

Import-Module -Name posh-git
Import-Module -Name Terminal-Icons

Invoke-Expression (&starship init powershell)

# Load all custom functions
. $functionsDirectory\Git-Functions.ps1
. $functionsDirectory\GitHub-Cli-Functions.ps1
. $functionsDirectory\NodeJS-Functions.ps1
. $functionsDirectory\Terminal-Functions.ps1
. $functionsDirectory\Video-Functions.ps1
. $functionsDirectory\ScreenResolution.ps1

# Load all custom completions
& "$completionsDirectory\Starship-Completions.ps1"
& "$completionsDirectory\Gh-Completions.ps1"
& "$completionsDirectory\Custom-Completions.ps1"

# Load all custom aliases
. $aliasesDirectory\Custom-Aliases.ps1
