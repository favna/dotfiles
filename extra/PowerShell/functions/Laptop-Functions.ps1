Function Set-Lavs-Location {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $False, ValueFromRemainingArguments = $True)]
        [string]
        $Repo
    )

    Process {
        if ($null -eq $Repo) {
            $Repo = 'lavs'
        }

        switch -regex ($Repo) {
            '^(?:lavs|main)' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs4'
            }
            '4' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs4'
            }
            '4primary' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs4'
            }
            '5' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs5'
            }
            '5primary' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs5'
            }
            Default {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs4'
            }
        }
    }
}


Function Set-Sharing-Resolution {
    $ChangeDisplay1Result = Set-ScreenResolutionEx 1920 1080 1

    if ($ChangeDisplay1Result -eq 'Failed To Change The Resolution.') {
        Set-ScreenResolutionEx 1920 1080 0
    }
}

Function Set-Working-Resolution {
    $ChangeDisplay1Result = Set-ScreenResolutionEx 3440 1440 1

    if ($ChangeDisplay1Result -eq 'Failed To Change The Resolution.') {
        Set-ScreenResolutionEx 3440 1440 0
    }
}

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
        $scriptDirectory = 'C:\Users\j.claassens\Documents\workspace\lavs\scripts'

        switch -regex ($Script) {
            build {
                & $scriptDirectory\Build-Backend.ps1 $Flags
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