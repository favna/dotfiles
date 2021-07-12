#!/usr/bin/env zsh

# Custom Aliases
alias x="exit"
alias dirsize="du -hcs ."
alias ylx="yarn2 dlx"
alias ps="pwsh -NoLogo"

gitalias() {
    cat ~/.oh-my-zsh/custom/plugins/zsh-git-enhanced/zsh-git-enhanced.plugin.zsh | grep $1
}
