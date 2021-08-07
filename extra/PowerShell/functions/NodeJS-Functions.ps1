Function yf {
	yarn --frozen-lockfile @Args
}

Function ylx {
	yarn2 dlx @Args
}

Function yarnclean {
	Remove-Item ((yarn cache dir) + '\*') -Force -Recurse -ErrorAction ignore;
	regenlockfile;
}

Function regenlockfile {
	Remove-Item -Recurse -Force .\node_modules -ErrorAction ignore;
	Remove-Item -Force .\yarn.lock -ErrorAction ignore;
	yarn install
}

Function Start-Yarn2 {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $False, ValueFromRemainingArguments = $True)]
        $Arguments
    )

    Process {
        node $PSScriptRoot\..\binaries\yarn2.js $Arguments
    }
}

Function Yarn-All-Repos {
	Get-ChildItem -Filter 'yarn.lock' -Recurse -Depth 2 -Exclude node_modules | ForEach-Object {
		$dirname = $_
		Push-Location $dirname\..\

		Write-Host "Running yarn install for ${dirname}" -ForegroundColor Green
		yf

		Write-Host '-------------' -ForegroundColor Gray
		Pop-Location
	}
}

Function Npm-All-Repos {
	Get-ChildItem -Filter 'package-lock.json' -Recurse -Depth 2 -Exclude node_modules | ForEach-Object {
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
	ylx http-server .\coverage\lcov-report\ -p 8081 -c-1 -o
}

Function Get-Docs {
	ylx http-server .\docs -p 8081 -c-1 -o
}

Function Open-Redis {
	Param (
		[string]$Database = 2
	)

	Process {
		redis-commander --redis-port 8287 --redis-host localhost --redis-password redis --redis-db $Database --open
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
