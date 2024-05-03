$functionsDirectory = "$PSScriptRoot\functions";
$completionsDirectory = "$PSScriptRoot\completions";
$aliasesDirectory = "$PSScriptRoot\aliases";

Import-Module git-aliases -DisableNameChecking
Import-Module Terminal-Icons
Import-Module z
Import-Module PSFzf
Import-Module PSReadLine

$PSReadLineOptions = @{
    PredictionSource    = 'History'
    PredictionViewStyle = 'ListView'
    Colors              = @{
        'Command' = '#8181f7'
        'Comment' = 'DarkGray'
    }
}

Set-PSReadLineOption @PSReadLineOptions
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# Load all custom functions
. $functionsDirectory\Git-Functions.ps1
. $functionsDirectory\Maven-Functions.ps1
. $functionsDirectory\Laptop-Functions.ps1
. $functionsDirectory\GitHub-Cli-Functions.ps1
. $functionsDirectory\NodeJS-Functions.ps1
. $functionsDirectory\Terminal-Functions.ps1
. $functionsDirectory\Video-Functions.ps1
. $functionsDirectory\ScreenResolution.ps1
. $functionsDirectory\ScreenSizing.ps1
. $functionsDirectory\GitHub-Copilot.ps1

# Load all custom completions
& "$completionsDirectory\Starship-Completions.ps1"
& "$completionsDirectory\Gh-Completions.ps1"
& "$completionsDirectory\Volta-Completions.ps1"
& "$completionsDirectory\Git-Cliff-Completions.ps1"

# Load all custom aliases
. $aliasesDirectory\Custom-Aliases.ps1

# Finally load posh-git, this needs to know about the custom functions and aliases
Import-Module posh-git -ArgumentList @($false, $false, $true)

$Env:STARSHIP_CONFIG = "$PSScriptRoot\starship.toml"
Invoke-Expression (&starship init powershell)
