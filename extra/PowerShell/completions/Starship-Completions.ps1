
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'starship' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'starship'
        for ($i = 1; $i -lt $commandElements.Count; $i++) {
            $element = $commandElements[$i]
            if ($element -isnot [StringConstantExpressionAst] -or
                $element.StringConstantType -ne [StringConstantType]::BareWord -or
                $element.Value.StartsWith('-') -or
                $element.Value -eq $wordToComplete) {
                break
        }
        $element.Value
    }) -join ';'

    $completions = @(switch ($command) {
        'starship' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('-V', 'V ', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('bug-report', 'bug-report', [CompletionResultType]::ParameterValue, 'Create a pre-populated GitHub issue with information about your configuration')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate starship shell completions for your shell to stdout')
            [CompletionResult]::new('config', 'config', [CompletionResultType]::ParameterValue, 'Edit the starship configuration')
            [CompletionResult]::new('explain', 'explain', [CompletionResultType]::ParameterValue, 'Explains the currently showing modules')
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Prints the shell function used to execute starship')
            [CompletionResult]::new('module', 'module', [CompletionResultType]::ParameterValue, 'Prints a specific prompt module')
            [CompletionResult]::new('preset', 'preset', [CompletionResultType]::ParameterValue, 'Prints a preset config')
            [CompletionResult]::new('print-config', 'print-config', [CompletionResultType]::ParameterValue, 'Prints the computed starship configuration')
            [CompletionResult]::new('prompt', 'prompt', [CompletionResultType]::ParameterValue, 'Prints the full starship prompt')
            [CompletionResult]::new('session', 'session', [CompletionResultType]::ParameterValue, 'Generate random session key')
            [CompletionResult]::new('time', 'time', [CompletionResultType]::ParameterValue, 'Prints time in milliseconds')
            [CompletionResult]::new('timings', 'timings', [CompletionResultType]::ParameterValue, 'Prints timings of all active modules')
            [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a given starship module')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'starship;bug-report' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'starship;completions' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'starship;config' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'starship;explain' {
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'The status code of the previously run command as an unsigned or signed 32bit integer')
            [CompletionResult]::new('--status', 'status', [CompletionResultType]::ParameterName, 'The status code of the previously run command as an unsigned or signed 32bit integer')
            [CompletionResult]::new('--pipestatus', 'pipestatus', [CompletionResultType]::ParameterName, 'Bash, Fish and Zsh support returning codes for each process in a pipeline')
            [CompletionResult]::new('-w', 'w', [CompletionResultType]::ParameterName, 'The width of the current interactive terminal')
            [CompletionResult]::new('--terminal-width', 'terminal-width', [CompletionResultType]::ParameterName, 'The width of the current interactive terminal')
            [CompletionResult]::new('-p', 'p', [CompletionResultType]::ParameterName, 'The path that the prompt should render for')
            [CompletionResult]::new('--path', 'path', [CompletionResultType]::ParameterName, 'The path that the prompt should render for')
            [CompletionResult]::new('-P', 'P ', [CompletionResultType]::ParameterName, 'The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument')
            [CompletionResult]::new('--logical-path', 'logical-path', [CompletionResultType]::ParameterName, 'The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument')
            [CompletionResult]::new('-d', 'd', [CompletionResultType]::ParameterName, 'The execution duration of the last command, in milliseconds')
            [CompletionResult]::new('--cmd-duration', 'cmd-duration', [CompletionResultType]::ParameterName, 'The execution duration of the last command, in milliseconds')
            [CompletionResult]::new('-k', 'k', [CompletionResultType]::ParameterName, 'The keymap of fish/zsh/cmd')
            [CompletionResult]::new('--keymap', 'keymap', [CompletionResultType]::ParameterName, 'The keymap of fish/zsh/cmd')
            [CompletionResult]::new('-j', 'j', [CompletionResultType]::ParameterName, 'The number of currently running jobs')
            [CompletionResult]::new('--jobs', 'jobs', [CompletionResultType]::ParameterName, 'The number of currently running jobs')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'starship;init' {
            [CompletionResult]::new('--print-full-init', 'print-full-init', [CompletionResultType]::ParameterName, 'print-full-init')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'starship;module' {
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'The status code of the previously run command as an unsigned or signed 32bit integer')
            [CompletionResult]::new('--status', 'status', [CompletionResultType]::ParameterName, 'The status code of the previously run command as an unsigned or signed 32bit integer')
            [CompletionResult]::new('--pipestatus', 'pipestatus', [CompletionResultType]::ParameterName, 'Bash, Fish and Zsh support returning codes for each process in a pipeline')
            [CompletionResult]::new('-w', 'w', [CompletionResultType]::ParameterName, 'The width of the current interactive terminal')
            [CompletionResult]::new('--terminal-width', 'terminal-width', [CompletionResultType]::ParameterName, 'The width of the current interactive terminal')
            [CompletionResult]::new('-p', 'p', [CompletionResultType]::ParameterName, 'The path that the prompt should render for')
            [CompletionResult]::new('--path', 'path', [CompletionResultType]::ParameterName, 'The path that the prompt should render for')
            [CompletionResult]::new('-P', 'P ', [CompletionResultType]::ParameterName, 'The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument')
            [CompletionResult]::new('--logical-path', 'logical-path', [CompletionResultType]::ParameterName, 'The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument')
            [CompletionResult]::new('-d', 'd', [CompletionResultType]::ParameterName, 'The execution duration of the last command, in milliseconds')
            [CompletionResult]::new('--cmd-duration', 'cmd-duration', [CompletionResultType]::ParameterName, 'The execution duration of the last command, in milliseconds')
            [CompletionResult]::new('-k', 'k', [CompletionResultType]::ParameterName, 'The keymap of fish/zsh/cmd')
            [CompletionResult]::new('--keymap', 'keymap', [CompletionResultType]::ParameterName, 'The keymap of fish/zsh/cmd')
            [CompletionResult]::new('-j', 'j', [CompletionResultType]::ParameterName, 'The number of currently running jobs')
            [CompletionResult]::new('--jobs', 'jobs', [CompletionResultType]::ParameterName, 'The number of currently running jobs')
            [CompletionResult]::new('-l', 'l', [CompletionResultType]::ParameterName, 'List out all supported modules')
            [CompletionResult]::new('--list', 'list', [CompletionResultType]::ParameterName, 'List out all supported modules')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'starship;preset' {
            [CompletionResult]::new('-o', 'o', [CompletionResultType]::ParameterName, 'Output the preset to a file instead of stdout')
            [CompletionResult]::new('--output', 'output', [CompletionResultType]::ParameterName, 'Output the preset to a file instead of stdout')
            [CompletionResult]::new('-l', 'l', [CompletionResultType]::ParameterName, 'List out all preset names')
            [CompletionResult]::new('--list', 'list', [CompletionResultType]::ParameterName, 'List out all preset names')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'starship;print-config' {
            [CompletionResult]::new('-d', 'd', [CompletionResultType]::ParameterName, 'Print the default instead of the computed config')
            [CompletionResult]::new('--default', 'default', [CompletionResultType]::ParameterName, 'Print the default instead of the computed config')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'starship;prompt' {
            [CompletionResult]::new('--profile', 'profile', [CompletionResultType]::ParameterName, 'Print the prompt with the specified profile name (instead of the standard left prompt)')
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'The status code of the previously run command as an unsigned or signed 32bit integer')
            [CompletionResult]::new('--status', 'status', [CompletionResultType]::ParameterName, 'The status code of the previously run command as an unsigned or signed 32bit integer')
            [CompletionResult]::new('--pipestatus', 'pipestatus', [CompletionResultType]::ParameterName, 'Bash, Fish and Zsh support returning codes for each process in a pipeline')
            [CompletionResult]::new('-w', 'w', [CompletionResultType]::ParameterName, 'The width of the current interactive terminal')
            [CompletionResult]::new('--terminal-width', 'terminal-width', [CompletionResultType]::ParameterName, 'The width of the current interactive terminal')
            [CompletionResult]::new('-p', 'p', [CompletionResultType]::ParameterName, 'The path that the prompt should render for')
            [CompletionResult]::new('--path', 'path', [CompletionResultType]::ParameterName, 'The path that the prompt should render for')
            [CompletionResult]::new('-P', 'P ', [CompletionResultType]::ParameterName, 'The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument')
            [CompletionResult]::new('--logical-path', 'logical-path', [CompletionResultType]::ParameterName, 'The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument')
            [CompletionResult]::new('-d', 'd', [CompletionResultType]::ParameterName, 'The execution duration of the last command, in milliseconds')
            [CompletionResult]::new('--cmd-duration', 'cmd-duration', [CompletionResultType]::ParameterName, 'The execution duration of the last command, in milliseconds')
            [CompletionResult]::new('-k', 'k', [CompletionResultType]::ParameterName, 'The keymap of fish/zsh/cmd')
            [CompletionResult]::new('--keymap', 'keymap', [CompletionResultType]::ParameterName, 'The keymap of fish/zsh/cmd')
            [CompletionResult]::new('-j', 'j', [CompletionResultType]::ParameterName, 'The number of currently running jobs')
            [CompletionResult]::new('--jobs', 'jobs', [CompletionResultType]::ParameterName, 'The number of currently running jobs')
            [CompletionResult]::new('--right', 'right', [CompletionResultType]::ParameterName, 'Print the right prompt (instead of the standard left prompt)')
            [CompletionResult]::new('--continuation', 'continuation', [CompletionResultType]::ParameterName, 'Print the continuation prompt (instead of the standard left prompt)')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'starship;session' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'starship;time' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'starship;timings' {
            [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'The status code of the previously run command as an unsigned or signed 32bit integer')
            [CompletionResult]::new('--status', 'status', [CompletionResultType]::ParameterName, 'The status code of the previously run command as an unsigned or signed 32bit integer')
            [CompletionResult]::new('--pipestatus', 'pipestatus', [CompletionResultType]::ParameterName, 'Bash, Fish and Zsh support returning codes for each process in a pipeline')
            [CompletionResult]::new('-w', 'w', [CompletionResultType]::ParameterName, 'The width of the current interactive terminal')
            [CompletionResult]::new('--terminal-width', 'terminal-width', [CompletionResultType]::ParameterName, 'The width of the current interactive terminal')
            [CompletionResult]::new('-p', 'p', [CompletionResultType]::ParameterName, 'The path that the prompt should render for')
            [CompletionResult]::new('--path', 'path', [CompletionResultType]::ParameterName, 'The path that the prompt should render for')
            [CompletionResult]::new('-P', 'P ', [CompletionResultType]::ParameterName, 'The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument')
            [CompletionResult]::new('--logical-path', 'logical-path', [CompletionResultType]::ParameterName, 'The logical path that the prompt should render for. This path should be a virtual/logical representation of the PATH argument')
            [CompletionResult]::new('-d', 'd', [CompletionResultType]::ParameterName, 'The execution duration of the last command, in milliseconds')
            [CompletionResult]::new('--cmd-duration', 'cmd-duration', [CompletionResultType]::ParameterName, 'The execution duration of the last command, in milliseconds')
            [CompletionResult]::new('-k', 'k', [CompletionResultType]::ParameterName, 'The keymap of fish/zsh/cmd')
            [CompletionResult]::new('--keymap', 'keymap', [CompletionResultType]::ParameterName, 'The keymap of fish/zsh/cmd')
            [CompletionResult]::new('-j', 'j', [CompletionResultType]::ParameterName, 'The number of currently running jobs')
            [CompletionResult]::new('--jobs', 'jobs', [CompletionResultType]::ParameterName, 'The number of currently running jobs')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'starship;toggle' {
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'starship;help' {
            [CompletionResult]::new('bug-report', 'bug-report', [CompletionResultType]::ParameterValue, 'Create a pre-populated GitHub issue with information about your configuration')
            [CompletionResult]::new('completions', 'completions', [CompletionResultType]::ParameterValue, 'Generate starship shell completions for your shell to stdout')
            [CompletionResult]::new('config', 'config', [CompletionResultType]::ParameterValue, 'Edit the starship configuration')
            [CompletionResult]::new('explain', 'explain', [CompletionResultType]::ParameterValue, 'Explains the currently showing modules')
            [CompletionResult]::new('init', 'init', [CompletionResultType]::ParameterValue, 'Prints the shell function used to execute starship')
            [CompletionResult]::new('module', 'module', [CompletionResultType]::ParameterValue, 'Prints a specific prompt module')
            [CompletionResult]::new('preset', 'preset', [CompletionResultType]::ParameterValue, 'Prints a preset config')
            [CompletionResult]::new('print-config', 'print-config', [CompletionResultType]::ParameterValue, 'Prints the computed starship configuration')
            [CompletionResult]::new('prompt', 'prompt', [CompletionResultType]::ParameterValue, 'Prints the full starship prompt')
            [CompletionResult]::new('session', 'session', [CompletionResultType]::ParameterValue, 'Generate random session key')
            [CompletionResult]::new('time', 'time', [CompletionResultType]::ParameterValue, 'Prints time in milliseconds')
            [CompletionResult]::new('timings', 'timings', [CompletionResultType]::ParameterValue, 'Prints timings of all active modules')
            [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle a given starship module')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'starship;help;bug-report' {
            break
        }
        'starship;help;completions' {
            break
        }
        'starship;help;config' {
            break
        }
        'starship;help;explain' {
            break
        }
        'starship;help;init' {
            break
        }
        'starship;help;module' {
            break
        }
        'starship;help;preset' {
            break
        }
        'starship;help;print-config' {
            break
        }
        'starship;help;prompt' {
            break
        }
        'starship;help;session' {
            break
        }
        'starship;help;time' {
            break
        }
        'starship;help;timings' {
            break
        }
        'starship;help;toggle' {
            break
        }
        'starship;help;help' {
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
