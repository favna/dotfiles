Function rlyd {
	regenlockfile && yarn dedupe @Args
}

Function gpshtyp {
	git push && git push --tags && yarn npm publish @Args
}

Function yarnclean {
	$YarnVersion = $(yarn --version)

	if ($YarnVersion.StartsWith('1')) {
		Remove-Item ($(yarn cache dir) + '\*') -Force -Recurse -ErrorAction ignore;
	}
	else {
		yarn cache clean --mirror @Args
	}

	regenlockfile;
}

Function regenlockfile {
	$currentNodeLinker = $(yarn config get nodeLinker)

	if ($currentNodeLinker.Equals('pnp')) {
		$currentCacheDirectory = $(yarn config get cacheFolder)
		Remove-Files-Recursively-Forced $currentCacheDirectory '.\yarn.lock'
	}
	else {
		Remove-Files-Recursively-Forced '.\node_modules' '.\yarn.lock'
	}

	yarn install
}

Function Yarn-All-Repos {
	Get-ChildItem -Directory |
	Where-Object Name -NotIn @('Windows', 'Program Files', '$Recycle.Bin', 'System Volume Information') |
	ForEach-Object {
		Get-ChildItem $_.FullName -File -Filter 'yarn.lock' -Recurse -Depth 2 -Exclude node_modules 
	} |
	ForEach-Object {
		$dirname = $_
		Push-Location $dirname\..\

		Write-Host "Running yarn install for ${dirname}" -ForegroundColor Green
		yii

		Write-Host '-------------' -ForegroundColor Gray
		Pop-Location
	}
}

Function Npm-All-Repos {
	Get-ChildItem -Directory |
	Where-Object Name -NotIn @('Windows', 'Program Files', '$Recycle.Bin', 'System Volume Information') |
	ForEach-Object {
		Get-ChildItem $_.FullName -File -Filter 'package-lock.json' -Recurse -Depth 2 -Exclude node_modules 
	} |
	ForEach-Object {
		$dirname = $_
		Push-Location $dirname\..\

		Write-Host "Running npm ci for ${dirname}" -ForegroundColor Green
		npm ci

		Write-Host '-------------' -ForegroundColor Gray
		Pop-Location
	}
}

Function Start-Npm-Upgrade {
	npm-upgrade
}

Function Get-Coverage {
	http-server .\coverage\lcov-report\ -gbso -p 8082 -c-1
}

Function Get-Docs {
	http-server .\docs -gbso -p 8082 -c-1
}

Function Open-Redis {
	Param (
		[string]$Database = 2,
		[string]$Port = 1424
	)

	Process {
		redis-commander --redis-port $Port --redis-host localhost --redis-password redis --redis-db $Database --open
	}
}

Function Generate-Gource {
	gource -f -1920x1080 --camera-mode overview -e 0.5 --background 0D1117 --date-format '%A, %d %B, %Y' -s 0.5 --user-image-dir .\.git\avatar\ --logo .\skyra.png --title 'Skyra Development History'
}

Function Disable-Node-Tls {
	$env:NODE_TLS_REJECT_UNAUTHORIZED = 0
}

Function Enable-Node-Tls {
	$env:NODE_TLS_REJECT_UNAUTHORIZED = 1
}

Function Flaky-TestCafe {
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $True)]
		$Path,
	
		[Parameter(Mandatory = $False)]
		$Runs
	)

	Process {
		$FinalTestResult = "Success"
		[int32[]]$FailedTests = @();

		if ($null -eq $Runs) {
			$Runs = 5
		}

		Write-Host "Running $Runs times" -ForegroundColor Blue

		for ($i = 1; $i -le $Runs; $i++) {
			Write-Host -ForegroundColor Yellow "run $i"

			yarn testcafe $Path

			$TestResult = $($?)

			if ($TestResult -eq $False) {
				$FinalTestResult = "Failed"
				$FailedTests += $i
			}
		}

		if ($FinalTestResult -eq "Success") {
			Write-Host -ForegroundColor Green "All runs passed"
		} else {
			Write-Host -ForegroundColor Red 'At least 1 test failed'
			Write-Host -ForegroundColor Red 'Failed test are:' $($FailedTests -join ',')
		}
	}
}
