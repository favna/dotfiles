# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
export SSH_AUTH_SOCK=~/.1password/agent.sock
export TERM="xterm-256color"
export VOLTA_HOME="$HOME/.volta"
export SDKMAN_DIR="$HOME/.sdkman"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$HOME/.local/bin:$VOLTA_HOME/bin:$HOME/.rover/bin:$PYENV_ROOT/bin"
export ZSH="$HOME/.oh-my-zsh"
export PROMPT_EOL_MARK=''
export GITHUB_TOKEN="nope"

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_DISABLE_COMPFIX="true"

STREAMABLEUSER="username"
STREAMABLEPASSWORD="password"

plugins=(
  1password
  colorize
  docker
  docker-compose
  fzf
  gh
  gradle
  poetry
  volta
  yarn
  zsh-autosuggestions
  zsh-git-enhanced
  zsh-syntax-highlighting
)

zstyle ':omz:plugins:yarn' berry yes

source $ZSH/oh-my-zsh.sh
source $HOME/.zprofile
source "$HOME/.cargo/env"

# Init brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Init pyenv
eval "$(pyenv init -)"

if [ "$WARP_IS_LOCAL_SHELL_SESSION" = "1" ]; then
  eval "$(zoxide init zsh)"
else
  eval "$(zoxide init --cmd cd zsh)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Init starship
if [ ! "$TERM_PROGRAM" = "vscode" ] && [ ! "$WARP_IS_LOCAL_SHELL_SESSION" = "1" ]; then
  eval "$(starship init zsh)"
fi

# Init GitHub Copilot
if command gh copilot >> /dev/null; then
  eval "$(gh copilot alias -- zsh)"
fi

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
