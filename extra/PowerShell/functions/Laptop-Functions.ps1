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
            test {
                & $scriptDirectory\Test.ps1 $Flags
            }
            Default {
                Write-Host 'Unknown script parameter detected' -ForegroundColor Red
            }
        }
    }
}

Function Build-Trigger {
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $True, ValueFromRemainingArguments = $True)]
        [string[]]
        $Flags
    )

    Process {
        $BaseMessage = 'Trigger Build'

        $Flags | ForEach-Object {
            switch ($_) {
                'ormas' { $BaseMessage += ' #RUN_ORMAS' }
                'order' { $BaseMessage += ' #RUN_ORDER_SUBSCRIPTION' }
                'plan' { $BaseMessage += ' #RUN_PLAN' }
                'spoor' { $BaseMessage += ' #RUN_SPOOR' }
                'vs' { $BaseMessage += ' #RUN_VS' }
                'all' { $BaseMessage += ' #RUN_ALL' }
            }
        }

        git cie -m "$BaseMessage"
    }
}


Function Set-Sharing-Resolution {
    Set-ScreenResolutionEx 1920 1080 1
}

Function Set-Working-Resolution {
    Set-ScreenResolutionEx 3440 1440 1
}
