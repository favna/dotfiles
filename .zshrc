export TERM="xterm-256color"
export VOLTA_HOME="$HOME/.volta"
export PATH="$PATH:$HOME/.local/bin:$VOLTA_HOME/bin:$HOME/.rover/bin:$HOME/.fig/bin:$JAVA_HOME/bin:$PYENV_ROOT/bin"
export ZSH="$HOME/.oh-my-zsh"
export PROMPT_EOL_MARK=''

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_DISABLE_COMPFIX="true"

STREAMABLEUSER="username"
STREAMABLEPASSWORD="password"

plugins=(
  zsh-git-enhanced
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $HOME/.zprofile

eval "$(starship init zsh)"
