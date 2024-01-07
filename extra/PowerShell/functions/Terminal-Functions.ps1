Function .. {
	Set-Location ../
}

Function ... {
	Set-Location ../../
}

Function .... {
	Set-Location ../../../
}

Function ..... {
	Set-Location ../../../../
}

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
	Get-ChildItem -Attributes ReadOnly, Hidden, System, Directory, Archive, Device, Normal, Temporary, SparseFile, ReparsePoint, Compressed, Offline, NotContentIndexed, Encrypted, IntegrityStream, NoScrubData @Args | Format-Wide -Column 3
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

Function sd {
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $True)]
		[int]
		$timeout,

		[Parameter(Mandatory = $False)]
		[string]
		$unit
	)
	
	Process {
		if ($null -eq $unit) {
			$unit = 'm'
		}

		$timeoutInSeconds = $timeout * 60

		if ($unit -eq 'h') {
			$timeoutInSeconds *= 60
		}

		shutdown.exe /s /t $timeoutInSeconds
	}
}

Function Docker-Compose-Alias {
	docker compose @Args
}

Function Spinel-Tunnel {
	cloudflared tunnel run spinel
}

Function Sleep-Monitors {
	$Code = @'
using System;
using System.Runtime.InteropServices;

namespace Sleeper {
	public class Sleeper {
		[DllImport("user32.dll")]
		public static extern int PostMessage(int hWnd, int hMsg, int wParam, int lParam);
	}
}
'@;
	Add-Type -TypeDefinition $Code
	[Sleeper.Sleeper]::PostMessage(0xffff, 0x0112, 0xF170, 2)  
}
