function Invoke-CopilotWhatTheShell {
    $TMPFILE = New-TemporaryFile;
    try {
        github-copilot-cli what-the-shell $args --shellout $TMPFILE
        if ($LASTEXITCODE -eq 0) {
            if (Test-Path $TMPFILE) {
                $FIXED_CMD = Get-Content -Raw $TMPFILE;
                Invoke-Expression $FIXED_CMD;
            }
            else {
                Write-Host 'Apologies! Extracting command failed';
            }
        }
        else {
            Write-Error 'Apologies! Copilot failed to generate a command';
        }
    }
    finally {
        Remove-Item $TMPFILE;
    }
}

function Invoke-CopilotGitAssist {
    $TMPFILE = New-TemporaryFile;
    try {
        github-copilot-cli git-assist $args --shellout $TMPFILE
        if ($LASTEXITCODE -eq 0) {
            if (Test-Path $TMPFILE) {
                $FIXED_CMD = Get-Content -Raw $TMPFILE;
                Invoke-Expression $FIXED_CMD;
            }
            else {
                Write-Host 'Apologies! Extracting command failed';
            }
        }
        else {
            Write-Error 'Apologies! Copilot failed to generate a command';
        }
    }
    finally {
        Remove-Item $TMPFILE;
    }
}

function Invoke-CopilotGitHubAssist {
    $TMPFILE = New-TemporaryFile;
    try {
        github-copilot-cli gh-assist $args --shellout $TMPFILE
        if ($LASTEXITCODE -eq 0) {
            if (Test-Path $TMPFILE) {
                $FIXED_CMD = Get-Content -Raw $TMPFILE;
                Invoke-Expression $FIXED_CMD;
            }
            else {
                Write-Host 'Apologies! Extracting command failed';
            }
        }
        else {
            Write-Error 'Apologies! Copilot failed to generate a command';
        }
    }
    finally {
        Remove-Item $TMPFILE;
    }
}

Set-Alias '??' 'Invoke-CopilotWhatTheShell';
Set-Alias 'gh?' 'Invoke-CopilotGitHubAssist';
Set-Alias 'wts' 'Invoke-CopilotWhatTheShell';
Set-Alias 'git?' 'Invoke-CopilotGitAssist';
