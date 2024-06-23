Function gbl {
	git branch -l
}

Function gfa {
	git fetch --all --prune --jobs=10 @Args
}

function gcom {
	$MainBranch = Get-Git-MainBranch

	git checkout origin/$MainBranch $args
}

Function gluc {
	$CurrentBranch = Get-Git-CurrentBranch

	git pull upstream $CurrentBranch
}

Function grau {
	git remote add upstream @Args
}

Function grad {
	git remote add downstream @Args
}

Function grlm {
	$CurrentBranch = Get-Git-CurrentBranch
	$MainBranch = Get-Git-MainBranch

	git rev-list --count $MainBranch..$CurrentBranch
}

Function grlmo {
	$CurrentBranch = Get-Git-CurrentBranch
	$MainBranch = Get-Git-MainBranch

	git rev-list --count origin/$MainBranch..$CurrentBranch
}

function grbom {
	$MainBranch = Get-Git-MainBranch

	git rebase origin/$MainBranch $args
}

Function gsd {
	$MainBranch = Get-Git-MainBranch

	git rebase -i HEAD~$(git rev-list --count origin/$MainBranch..$(git rev-parse --abbrev-ref HEAD))
}

function gswc {
	git switch --create $args
}

Function gswm {
	$MainBranch = Get-Git-MainBranch

	git switch $MainBranch
}

function Push-WhatTheCommit() {
	Commit-WhatTheCommit $args
	git push
}

function Commit-WhatTheCommit {
	Param (
		[string]$fixup = ''
	)

	Process {
		$commitMessage = Invoke-RestMethod -Uri 'https://whatthecommit.com/index.txt' | ForEach-Object { $_.ToLower() }

		if ($fixup.Equals('fixup')) {
			git commit --no-verify --all --fixup "chore: $commitMessage"
		}
		else {
			git commit --no-verify --all --message "chore: $commitMessage"
		}
	}
}

function gbdaf() {
	$MainBranch = Get-Git-MainBranch
	$NotMainBranches = $(git branch | Select-String "^(\*|\s*($MainBranch|develop|dev)\s*$)" -NotMatch).Line
	$NotMainBranches | ForEach-Object {
		if ([string]::IsNullOrEmpty($_)) {
			return
		}
		git branch --delete --force $_.Trim()
	}
}

function gbd() {
	git branch --delete --force $args
}

function Delete-BranchRegex {
	param(
		[string]$pattern
	)

	git branch --no-color --merged | Where-Object { $_ -match $pattern } | ForEach-Object {
		git branch --delete $_.Trim() > $null 2>&1
	}
}

function Delete-BranchRegexForce {
	param(
		[string]$pattern
	)

	git branch --no-color --merged | Where-Object { $_ -match $pattern } | ForEach-Object {
		git branch --delete --force $_.Trim() > $null 2>&1
	}
}

Function Refresh-Tags {
	git fetch --prune origin "+refs/tags/*:refs/tags/*" && git fetch -t
}

Function gitalias {
	Get-Git-Aliases | findstr -i @args
}

Set-Alias -Name gcy -Value Commit-WhatTheCommit
Set-Alias -Name gy -Value Push-WhatTheCommit
Set-Alias -Name gbdr -Value Delete-BranchRegex
Set-Alias -Name gbdrf -Value Delete-BranchRegexForce
Set-Alias -Name gpt -Value Refresh-Tags

Function Get-All-Repos {
	Get-ChildItem -Directory |
	Where-Object Name -NotIn @('Windows', 'Program Files', '$Recycle.Bin', 'System Volume Information') |
	ForEach-Object {
		Get-ChildItem $_.FullName -Directory -Hidden -Filter '.git' -Recurse -Depth 2 -Exclude node_modules 
	} |
	ForEach-Object {
		$dirname = $_
		Push-Location $dirname\..\

		Write-Host "Processing git status in ${dirname}" -ForegroundColor Green
		Clear-Branches -q

		$STATUS = $(git status | grep -v 'nothing to commit' | grep -v 'up-to-date' | grep -v '^On branch (?:master|main)$')

		if (Get-Variable 'STATUS' -ErrorAction 'Ignore') {
			Write-Host $STATUS | grep --color -E '^|behind|ahead|On branch .*'
		}

		if ($STATUS -like '*can be fast-forwarded*') {
			git pull
		}

		Write-Host '-------------' -ForegroundColor Gray
		Pop-Location
	}
}

Function Clear-Branches {
	Write-Host 'Fetching and pruning remotes' -ForegroundColor Green

	git fetch --all --prune @Args

	Write-Host 'Pruning local branches' -ForegroundColor Magenta

	foreach ($branch in $(gbdaf)) {
		Write-Host $branch -ForegroundColor Red
	}

	Write-Host '-------------' -ForegroundColor Gray
}
