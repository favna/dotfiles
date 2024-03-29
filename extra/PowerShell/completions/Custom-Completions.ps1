Register-ArgumentCompleter -CommandName Set-SkyraProject-Location -ParameterName Repo -ScriptBlock {
	Get-ChildItem F:\dev\skyraproject -Name -Directory
}

Register-ArgumentCompleter -CommandName Set-SapphireDev-Location -ParameterName Repo -ScriptBlock {
	Get-ChildItem F:\dev\sapphiredev -Name -Directory
}

Register-ArgumentCompleter -CommandName Set-Favware-Location -ParameterName Repo -ScriptBlock {
	Get-ChildItem F:\dev\favware -Name -Directory
}

Register-ArgumentCompleter -CommandName Set-Lavs-Location -ParameterName Repo -ScriptBlock {
	Write-Output @('main', 'lavs', '4', '5primary', '4secondary', '5', '5primary', '5secondary')
}

Register-ArgumentCompleter -CommandName Run-Script -ParameterName Script -ScriptBlock {
	Write-Output @('build', 'package', 'wars', 'jboss', 'logs', 'clearlogs', 'console')
}
