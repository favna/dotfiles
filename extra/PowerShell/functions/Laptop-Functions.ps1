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
        $scriptDirectory = 'C:\Users\j.claassens\Documents\workspace\wlis\scripts'

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
        [ValidateNotNull()]
        [string[]]
        $Flags
    )

    Process {
        $BaseMessage = 'Trigger Build'

        $Flags | ForEach-Object {
            switch ($_) {
                'extended' { $BaseMessage += ' #RUN_EXTENDED_TESTS' }
                'all' { $BaseMessage += ' #RUN_ALL' }
                'bff' { $BaseMessage += ' #RUN_BFF' }
                'bds' { $BaseMessage += ' #RUN_BDS' }
                'docu' { $BaseMessage += ' #DOCU' }
                'order' { $BaseMessage += ' #RUN_ORDER' }
                'plan' { $BaseMessage += ' #RUN_PLAN' }
                'spoor' { $BaseMessage += ' #RUN_SPOOR' }
                'vs' { $BaseMessage += ' #RUN_VS' }
                'deploy' { $BaseMessage += ' #DEPLOY' }
            }
        }

        git cie -m "$BaseMessage"
    }
}

Function Set-Wlis-Location {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $False, ValueFromRemainingArguments = $True)]
        [string]
        $Repo
    )

    Process {
        if ($null -eq $Repo) {
            $Repo = 'wlis'
        }

        switch -regex ($Repo) {
            '^(?:wlis|main)' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\wlis\wlis'
            }
            'secondary' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\wlis\wlisSecondary'
            }
            'tertiary' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\wlis\wlisTertiary'
            }
            'quaternary' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\wlis\wlisQuaternary'
            }
            'quinary' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\wlis\wlisQuinary'
            }
            Default {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\wlis\wlis'
            }
        }
    }
}

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
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs4primary'
            }
            '4' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs4primary'
            }
            '4primary' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs4primary'
            }
            '4secondary' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs4secondary'
            }
            '5' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs5primary'
            }
            '5primary' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs5primary'
            }
            '5secondary' {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs5secondary'
            }
            Default {
                Set-Location -Path 'C:\Users\j.claassens\Documents\workspace\lavs\lavs4primary'
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

Function Switch-Java-Version {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [int]
        $Version
    )

    Process {
        $HasChangedJavaVersion = $False

        switch ($Version) {
            8 {
                $JAVA_HOME = 'C:\Program Files\Eclipse Adoptium\jdk-8.0.352.8-hotspot'
                [Environment]::SetEnvironmentVariable('JAVA_HOME', "${JAVA_HOME}", 'USER')

                $current_PATH = [Environment]::GetEnvironmentVariable('PATH', 'USER');
                [Environment]::SetEnvironmentVariable('PATH', "${JAVA_HOME}\bin;$current_PATH;", 'USER')

                $HasChangedJavaVersion = $True
                Write-Host 'Java 8 activated.' -ForegroundColor Black -BackgroundColor DarkGreen
            }
            11 {
                $JAVA_HOME = 'C:\Program Files\AdoptOpenJDK\jdk-11.0.10.9-hotspot'
                [Environment]::SetEnvironmentVariable('JAVA_HOME', "${JAVA_HOME}", 'USER')

                $current_PATH = [Environment]::GetEnvironmentVariable('PATH', 'USER');
                [Environment]::SetEnvironmentVariable('PATH', "${JAVA_HOME}\bin;$current_PATH;", 'USER')

                $HasChangedJavaVersion = $True
                Write-Host 'Java 11 activated.' -ForegroundColor Black -BackgroundColor DarkGreen
            }
            Default {
                Write-Host 'Unknown Java Version' -ForegroundColor White -BackgroundColor DarkRed -NoNewline
            }
        }

        if ($HasChangedJavaVersion) {
            # Reload the PATH
            $env:Path = [System.Environment]::ExpandEnvironmentVariables([System.Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path', 'User'))
            Write-Host 'Path reloaded.' -ForegroundColor Black -BackgroundColor DarkGreen -NoNewline
        }
    }
}