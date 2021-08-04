Register-ArgumentCompleter -CommandName Set-SkyraProject-Location -ParameterName Repo -ScriptBlock {
	Get-ChildItem F:\dev\skyraproject -Name -Directory
}

Register-ArgumentCompleter -CommandName Set-SapphireDev-Location -ParameterName Repo -ScriptBlock {
	Get-ChildItem F:\dev\sapphiredev -Name -Directory
}

Register-ArgumentCompleter -CommandName Set-Favware-Location -ParameterName Repo -ScriptBlock {
	Get-ChildItem F:\dev\favware -Name -Directory
}