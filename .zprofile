#!/usr/bin/env zsh

GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
RED=$(tput setaf 1)

alias x="exit"
alias dirsize="du -hcs ."
alias ps="pwsh -NoLogo"
alias gy="git yolo"
alias gcy="git ciyolo"
alias gsd="git squashdiff"
alias bdr="git br-delete-regex"
alias bdu="git br-delete-useless-force"
alias bduf="git br-delete-useless-force"
alias ghpc="gh pr checkout"
alias ghvp="gh pr view -w"
alias ghv="gh repo view -w"
alias rmf="rm -rf"
alias dc="docker compose"
alias spinel="cloudflared tunnel run spinel"
alias gpp="git push"
alias gpl="git pull"
alias y="yarn"
alias yb="yarn build"
alias yc="yarn clean"
alias yt="yarn test"
alias ybu="yarn bump"
alias ycu="yarn check-update"
alias yui="yarn upgrade-interactive"
alias rlyd="regenlockfile && yarn dedupe"
alias gpshtyp="git push && git push --tags && yarn npm publish"
alias python="python3"
alias air="$AIR_DEV_PATH/tools/aio.sh"
alias aio="$AIR_DEV_PATH/tools/aio.sh"
alias lag="ls -al | grep"
alias bunny="bun i"

printgreen() {
  printf "${GREEN}$@${NORMAL}\n"
}

printred() {
  printf "${RED}$@${NORMAL}\n"
}

printgrey() {
  printf "${NORMAL}$@${NORMAL}\n"
}

gitalias() {
    cat ~/.oh-my-zsh/custom/plugins/zsh-git-enhanced/zsh-git-enhanced.plugin.zsh | grep $1
}

streamupload() {
  code=$(curl --request POST --url https://api.streamable.com/upload --user $STREAMABLEUSER:$STREAMABLEPASSWORD --form file=@"$1" | jq -r '.shortcode');
  echo Added https://streamable.com/$code to your clipboard;
  echo https://streamable.com/$code | pbcopy;
}

getallrepos() {
  originallocation=$(pwd)

  find ~+ -name ".git" -type d -maxdepth 3 -not -path "*node_modules*" -print0 | while read -d $'\0' dir
  do
    cd $dir/..
    printgreen "Processing git status in $dir"
    clear-branches

    gitstatus=$(git status | grep -v 'nothing to commit' | grep -v 'up-to-date' | grep -v '^On branch (?:master|main)$')

    if [[ ! -z $gitstatus ]];
    then
      echo $gitstatus | grep --color -E '^|behind|ahead|On branch .*';
    fi

    if [[ $gitstatus =~ ".*can be fast-forwarded.*" ]];
    then
        git pull;
    fi

    printgrey "-------------"

  done

  cd $originallocation
}

clear-branches() {
  printgreen "Fetching and pruning remotes"

  git fetch --all --prune

  printgreen "Pruning local branches"

  git br-delete-useless-force

  printgrey "-------------"
}

yf() {
    yarnversion=$(yarn --version)

    if [[ $yarnversion =~ "^1" ]];
    then
        yarn --frozen-lockfile $@
    else
        yarn --immutable $@
    fi
}

yarnclean() {
    yarnversion=$(yarn --version)

    if [[ $yarnversion =~ "^1" ]];
    then
        rmf `yarn cache dir`/* $@
    else
        yarn cache clean --mirror $@
    fi

    regenlockfile
}

regenlockfile() {
    currentNodeLinker=$(yarn config get nodeLinker)

    if [ "${currentNodeLinker}" = "pnp" ]; then
      currentCacheDirectory=$(yarn config get cacheFolder)
      rmf ${currentCacheDirectory} ./yarn.lock
      yarn install
    else
      rmf ./node_modules ./yarn.lock
    fi
}

yarnallrepos() {
  originallocation=$(pwd)

  find ~+ -name "yarn.lock" -type f -maxdepth 3 -not -path "*node_modules*" -print0 | while read -d $'\0' file
  do
    dir=$(dirname $file)

    cd $dir

    printgreen "Running yarn install for $dir"

    yf

    printgrey "-------------"

  done

  cd $originallocation
}

npmallrepos() {
  originallocation=$(pwd)

  find ~+ -name "package-lock.json" -type f -maxdepth 3 -not -path "*node_modules*" -print0 | while read -d $'\0' file
  do
    dir=$(dirname $file)

    cd $dir

    printgreen "Running npm ci for $dir"

    npm ci

    printgrey "-------------"

  done

  cd $originallocation
}

getcoverage() {
    open ./coverage/lcov-report/index.html
}

getdocs() {
    open ./docs/index.html
}

openredis() {
    redis-commander --redis-port 8287 --redis-host localhost --redis-password redis --redis-db ${1:-2} --open
}

generategource() {
    gource -f -1920x1080 --camera-mode overview -e 0.5 --background 0D1117 --date-format '%A, %d %B, %Y' -s 0.5 --user-image-dir ./.git/avatar/ --logo ./skyra.png --title 'Skyra Development History'
}

disable-node-tls() {
    export NODE_TLS_REJECT_UNAUTHORIZED="0"
}

enable-node-tls() {
    export NODE_TLS_REJECT_UNAUTHORIZED="1"
}

cutvideo() {
    ffmpeg -i $1 -ss $2 -to $3 -y ./out.mp4
}

cutvideocopy() {
    ffmpeg -i $1 -ss $2 -to $3 -c:v copy -c:a copy -y ./out.mp4
}

compressvideo() {
    ffmpeg -i $1 -b:v 12800k -c:a copy -y ./out.mp4
}

update-volta-cli-tools() {
  volta install \
    @arethetypeswrong/cli \
    @favware/cliff-jumper \
    @favware/npm-deprecate \
    @favware/rollup-type-bundler \
    @sapphire/cli \
    eslint \
    fkill-cli \
    pnpm \
    prettier \
    rollup \
    tsup \
    turbo \
    typescript \
    vitest
}
