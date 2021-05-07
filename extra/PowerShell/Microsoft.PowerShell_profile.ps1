﻿$Env:STARSHIP_CONFIG = "$Env:USERPROFILE\Documents\PowerShell\starship.toml"

Import-Module posh-git
Import-Module -Name Terminal-Icons

Invoke-Expression (&starship init powershell)

#region Helper functions

Function Get-Current-Git-Branch() {
  git rev-parse --abbrev-ref HEAD
}

#endregion
#region Git aliases

Function gst {
  git status @Args
}

Function gba {
  git branch -a 
}

Function gbl {
  git branch -l
}

Function gpp {
  git push @Args
}

Function gpl {
  git pull @Args
}

Function gfa {
  git fetch --all --prune @Args
}

Function gco {
  git checkout @Args
}

Function gcom {
  git checkout origin/main @Args
}

Function gcbb {
  git checkout -b @Args
}

Function gpf {
  git push --force
}

Function gpsup {
  $currentBranch = Get-Current-Git-Branch
  git push --set-upstream origin $currentBranch
}

Function grset {
  git remote set-url @Args
}

Function gcl {
  git clone @Args
}

Function grlm {
  $currentBranch = Get-Current-Git-Branch
  git rev-list --count main..$currentBranch
}

Function grlmo {
  $currentBranch = Get-Current-Git-Branch
  git rev-list --count origin/main..$currentBranch
}

Function grbac {
  git rebase --abort
}

Function grbm {
  git rebase origin/main
}

Function grbc {
  git rebase --continue
}

#endregion

#region GH CLI aliases

Function gh-prc {
  gh pr checkout @Args
}

Function gh-pra {
  gh pr review -a @Args
}

Function gh-prd {
  gh pr review -d @Args
}

#endregion

#region Yarn helper functions

Function ylx {
  yarn2 dlx @Args
}

Function yarnclean {
  Remove-Item ((yarn cache dir) + "\*") -Force -Recurse -ErrorAction ignore;
  regenlockfile;
}

Function regenlockfile {
  Remove-Item -Recurse -Force .\node_modules -ErrorAction ignore;
  Remove-Item -Force .\yarn.lock -ErrorAction ignore;
  yarn install
}

Function Yarn-All-Repos {
  Get-ChildItem -Filter "yarn.lock" -Recurse -Depth 2 -Exclude node_modules | ForEach-Object {
    $dirname=$_
    Push-Location $dirname\..\

    Write-Host "Running yarn install for ${dirname}" -ForegroundColor Green
    yf

    Write-Host "-------------" -ForegroundColor Gray
    Pop-Location
  }
}

#endregion
#region Misc

Function Get-All-Repos {
  Get-ChildItem -Directory -Hidden -Filter ".git" -Recurse -Depth 2 -Exclude node_modules | ForEach-Object {
    $dirname=$_
    Push-Location $dirname\..\

    Write-Host "Processing git status in ${dirname}" -ForegroundColor Green
    git fetch --all -q --prune

    $STATUS=$(git status | grep -v 'nothing to commit' |  grep -v 'up-to-date' | grep -v '^On branch (?:master|main)$')

    if(Get-Variable 'STATUS' -ErrorAction 'Ignore') {
      Write-Host $STATUS | grep --color -E '^|behind|ahead|On branch .*'
    }

    if ($STATUS -like '*can be fast-forwarded*') {
      git pull
    }

    Write-Host "-------------" -ForegroundColor Gray
    Pop-Location
  }
}

Function Clear-Branches {
  Write-Host "Fetching and pruning remotes" -ForegroundColor Green
  git fetch --all --prune
  Write-Host "Pruning local branches" -ForegroundColor Green
  git br-delete-useless-force 
  Write-Host "-------------" -ForegroundColor Gray
}

function Get-Coverage {
  ylx http-server .\coverage\lcov-report\ -p 8081 -c-1 -o
}

function Get-Docs {
  ylx http-server .\docs -p 8081 -c-1 -o
}

Function Update-Env {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

Function la {
    Get-ChildItem -Attributes ReadOnly,Hidden,System,Directory,Archive,Device,Normal,Temporary,SparseFile,ReparsePoint,Compressed,Offline,NotContentIndexed,Encrypted,IntegrityStream,NoScrubData @Args
}

Function yf {
  yarn --frozen-lockfile
}

Function Cut-Video {
  ffmpeg -i $args[0] -ss $args[1] -to $args[2] -y .\out.mp4
}

Function saph {
  Set-Location -Path (-join("E:\dev\sapphireproject\", $args[0]))
}

Function sky {
  Set-Location -Path (-join("E:\dev\skyraproject\", $args[0]))
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
  gource -f -1920x1080 --camera-mode overview -e 0.5 --background 0D1117 --date-format "%A, %d %B, %Y" -s 0.5 --user-image-dir .\.git\avatar\ --logo .\skyra.png --title "Skyra Development History"
}

Function x {
  exit;
}

#endregion
#region Aliases

Set-Alias -Name g -Value git
Set-Alias -Name allc -Value all-contributors
Set-Alias -Name gti -Value git
Set-Alias -Name dc -Value docker-compose

#endregion

#region Completions 
& "$Env:USERPROFILE\Documents\PowerShell\Starship-Completions.ps1"
& "$Env:USERPROFILE\Documents\PowerShell\Gh-Completions.ps1"
#endregion