function .. {
	Set-Location ../
}

function ... {
	Set-Location ../../
}

function .... {
	Set-Location ../../../
}

function ..... {
	Set-Location ../../../../
}

function Remove-Files-Recursively-Forced {
	param(
		[Parameter(ValueFromRemainingArguments = $True)]
		[String[]]$Paths
	)
	process {
		foreach ($path in $Paths) {
			Remove-Item -Recurse -Force -Path $path -ErrorAction Ignore
		}
	}
}


function Update-Env {
	$env:Path = [System.Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path', 'User')
}

function la {
	Get-ChildItem -Attributes ReadOnly, Hidden, System, Directory, Archive, Device, Normal, Temporary, SparseFile, ReparsePoint, Compressed, Offline, NotContentIndexed, Encrypted, IntegrityStream, NoScrubData @Args | Format-Wide -Column 3
}

function x {
	exit;
}

function sd {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $True)]
		[int]
		$timeout,

		[Parameter(Mandatory = $False)]
		[string]
		$unit
	)
	
	process {
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

function Podman-Compose-Alias {
	podman compose $args
}

function Spinel-Tunnel {
	cloudflared tunnel run spinel
}

function Sleep-Monitors {
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
