Function Remove-Files-Recursively-Forced {
	Param(
		[Parameter(ValueFromRemainingArguments = $True)]
		[String[]]$Paths
	)
	Process {
		ForEach ($path in $Paths) {
			Remove-Item -Recurse -Force -Path $path -ErrorAction Ignore
		}
	}
}


Function Update-Env {
	$env:Path = [System.Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path', 'User')
}

Function la {
	Get-ChildItem -Attributes ReadOnly, Hidden, System, Directory, Archive, Device, Normal, Temporary, SparseFile, ReparsePoint, Compressed, Offline, NotContentIndexed, Encrypted, IntegrityStream, NoScrubData @Args
}

Function Set-SapphireDev-Location {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $False, ValueFromRemainingArguments = $False)]
		$Repo
	)

	Process {
		Set-Location -Path ( -join ('F:\dev\sapphiredev\', $Repo))
	}
}

Function Set-SkyraProject-Location {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $False, ValueFromRemainingArguments = $False)]
		$Repo
	)

	Process {
		Set-Location -Path ( -join ('F:\dev\skyraproject\', $Repo))
	}
}

Function Set-Favware-Location {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $False, ValueFromRemainingArguments = $False)]
		$Repo
	)

	Process {
		Set-Location -Path ( -join ('F:\dev\favware\', $Repo))
	}
}


Function x {
	exit;
}
