Function Run-Script {
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $True)]
        [ValidateNotNull()]
        [string]
        $Script,

        [Parameter(Position = 1, Mandatory = $False, ValueFromRemainingArguments = $True)]
        [string[]]
        $Flags
    )

    Process {
        $scriptDirectory = 'C:\Users\j.claassens\Documents\workspace\scripts'

        switch -regex ($Script) {
            build {
                & $scriptDirectory\Build-Frontend.ps1 $Flags
            }
            package {
                & $scriptDirectory\Build-Backend.ps1 $Flags
            }
            wars {
                & $scriptDirectory\Deploy-Wars.ps1 $Flags
            }
            jboss {
                & $scriptDirectory\Start-Jboss.ps1 $Flags
            }
            '^(?:logs|clearlogs|clear-logs)' {
                & $scriptDirectory\Clear-Logs.ps1 $Flags
            }
            console {
                & $scriptDirectory\Start-Jboss-Console.ps1 $Flags
            }
            Default {
                Write-Host 'Unknown script parameter detected' -ForegroundColor Red
            }
        }
    }
}
