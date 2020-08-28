#!/usr/bin/env zsh

# Custom Aliases
alias yarnclean="rm -rf `yarn cache dir`/* && rm -rf node_modules yarn.lock && yarn install"
alias klasaclean="rm -rf `yarn cache dir`/*discord* && rm -rf `yarn cache dir`/*klasa* && rm -rf node_modules yarn.lock && yarn --frozen-lockfile --force"
alias x="exit"
alias dirsize="du -hcs ."
alias ylx="yarn2 dlx"
alias ps="pwsh -NoLogo"

gitalias() {
    cat ~/.oh-my-zsh/custom/plugins/zsh-git-enhanced/zsh-git-enhanced.plugin.zsh | grep $1
}
