Function Run-Script {
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $True)]
        [ValidateNotNull()]
        [string]
        $Script
    )

    Process {
        $scriptDirectory = "C:\Users\j.claassens\Documents\workspace\scripts"

        switch -regex ($Script) {
            build {
                & $scriptDirectory\Build-Frontend @Args
            }
            package {
                & $scriptDirectory\Build-Backend @Args
            }
            wars {
                & $scriptDirectory\Deploy-Wars @Args
            }
            jboss {
                & $scriptDirectory\Start-Jboss @Args
            }
            "^(?:logs|clearlogs|clear-logs)" {
                & $scriptDirectory\Clear-Logs @Args
            }
            console {
                & $scriptDirectory\Start-Jboss-Console @Args
            }
            Default {
                Write-Host "Unknown script parameter detected" -ForegroundColor Red
            }
        }
    }
}
