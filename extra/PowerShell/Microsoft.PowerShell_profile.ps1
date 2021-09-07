$functionsDirectory = "$PSScriptRoot\functions";
$completionsDirectory = "$PSScriptRoot\completions";
$aliasesDirectory = "$PSScriptRoot\aliases";

$Env:STARSHIP_CONFIG = "$PSScriptRoot\starship.toml"

Import-Module -Name posh-git
Import-Module -Name Terminal-Icons

Invoke-Expression (&starship init powershell)
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

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
