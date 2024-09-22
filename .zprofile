#!/usr/bin/env zsh

# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh"

GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
RED=$(tput setaf 1)

alias x="exit"
alias dirsize="du -hcs ."
alias ps="pwsh -NoLogo"
alias ghvp="gh pr view -w"
alias ghv="gh repo view -w"
alias rmf="rm -rf"
alias dc="docker compose"
alias spinel="cloudflared tunnel run spinel"
alias gpp="git push"
alias gpl="git pull"
alias rlyd="regenlockfile && yarn dedupe"
alias gpshtyp="git push && git push --tags && yarn npm publish"
alias python="python3"
alias aio="$AIR_DEV_PATH/tools/aio.sh"
alias bunny="bun i"
alias neofetch="fastfetch"

lag() {
  if [[ $# -eq 0 ]]; then
    printred "You should provide a grep filter (and optionally path) to search for."
  elif [[ $# -eq 1 ]]; then
    ls -al . | grep $@
  else
    lsPath=$1
    shift 1
    ls -al ${lsPath} | grep $@
  fi
}

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

  gfa

  printgreen "Pruning local branches"

  gbdaf

  printgrey "-------------"
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

    yii

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
    @favware/discord-application-emojis-manager \
    @githubnext/github-copilot-cli \
    @sapphire/cli \
    commitizen \
    eslint \
    fkill-cli \
    gen-esm-wrapper \
    http-server \
    pnpm \
    prettier \
    rollup \
    serve \
    ts-node \
    tsup \
    turbo \
    typescript \
    vitest
}

source $HOME/.rover/env

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zprofile.post.zsh"
